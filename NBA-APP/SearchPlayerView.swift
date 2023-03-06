//
//  SearchPlayerView.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/6/23.
//

import SkeletonUI
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchKey = ""
    @Published var executionTimes = 0
}

struct SearchPlayerView: View {
    @EnvironmentObject var network: Network
    @StateObject var viewModel = SearchViewModel()
    @State var players: [PlayerSportsIo] = []
    @State var selectedPlayer: PlayerSportsIo = PlayerSportsIo()
    @State var searchResults: [PlayerSportsIo] = []
    @State var navigateToDetailView: Bool = false
    
    @State var loading = true
    
    func searchPlayers(_ key: String) {
        if (key == "") {
            searchResults = players
        }
        searchResults = players.filter{ player in
            let playerName = "\(player.firstName ?? "") \(player.lastName ?? "")".lowercased()
            return playerName.contains(key.lowercased())
        }
    }

    var body: some View {
        VStack {
            TextField(
              "Enter Player Name..",
              text: $viewModel.searchKey
            )
            .customFont(.title4)
            .textFieldStyle(.roundedBorder)
            .onReceive(
                viewModel.$searchKey.debounce(for: 1, scheduler: RunLoop.main)
             ) { searchKey in
                viewModel.executionTimes += 1
                 searchPlayers(viewModel.searchKey)
            }
            
            if (loading) {
                Rectangle()
                    .skeleton(with: loading)
                    .shape(type: .rectangle)
                    .multiline(lines: 6)
                    .animation(type: .pulse())
                    .padding(.top, 10)
            }
            
            if (searchResults.count == 0 && !loading) {
                Spacer()
                Spacer()
                Text("No Results").customFont(.subheadline)
            }
            
            ScrollView(.vertical) {
                if (!loading) {
                    LazyVStack(alignment: .leading) {
                        ForEach(searchResults, id: \.playerID) { result in
                            Button {
                                selectedPlayer = result
                                navigateToDetailView = true
                            } label: {
                                HStack {
                                    AsyncImage(url: URL(string:  result.photoURL!)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
            
                                    } placeholder: {
                                        //put your placeholder here
                                    }
                                    .frame(width: 50)
                                    .clipShape(Circle())
                                    
                                    VStack(alignment: .leading) {
                                        Text(result.fantasyDraftName ?? "-")
                                            .customFont(.title4)
                                        Text("\(result.team ?? "-") - \(result.position ?? "-")")
                                            .customFont(.footnote)
                                            .foregroundColor(.black.opacity(0.7))
                                    }
                                    Spacer()
                                    Image(systemName: "arrow.forward")
                                    
                                }
                                .id(result.playerID)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 10)
                                .sheet(isPresented: $navigateToDetailView) {
                                    PlayerDetailView(player: $selectedPlayer)
                                }
                            }
                            .foregroundColor(.black)
                            Divider()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                }
            }
        }
        .padding(20)
        .task {
            loading = true
            let _players = await network.getActivePlayers()
            players = _players
            searchPlayers("")
            loading = false
        }
    }
}

struct SearchPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlayerView(selectedPlayer: getMockPlayerSports()[0])
            .environmentObject(Network())
    }
}
