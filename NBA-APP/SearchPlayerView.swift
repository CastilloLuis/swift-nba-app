//
//  SearchPlayerView.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/6/23.
//

import SwiftUI

class TestsViewModel: ObservableObject {
    @Published var searchKey = ""
    @Published var executionTimes = 0
}

struct SearchPlayerView: View {
    @StateObject var viewModel = TestsViewModel()
    let players: [PlayerSportsIo] = getMockPlayerSports()
    @State var searchResults: [PlayerSportsIo] = []
    @State var navigateToDetailView: Bool = false
    
    func searchPlayers(_ key: String) {
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

            
            if (searchResults.count == 0) {
                Spacer()
                Spacer()
                Text("No Results").customFont(.subheadline)
            }
            
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading) {
                    ForEach(searchResults, id: \.playerID) { result in
                        Button {
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
                                PlayerDetailView()
                            }
//                            .navigationDestination(isPresented: $navigateToDetailView) {
//                                PlayerDetailView()
//                            }
                        }
                        .foregroundColor(.black)
                        Divider()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
            }
        }
        .padding(20)
    }
}

struct SearchPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlayerView()
    }
}
