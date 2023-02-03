//
//  HomeView.swift
//  NBA-APP
//
//  Created by Luis Castillo on 1/31/23.
//

import SwiftUI

enum StatsTabs {
    case hTeam, vTeam, stats
}

struct HomeView: View {
    @EnvironmentObject var network: Network
    @State var liveGames: [LiveGame] = getMockGames()
    @State var latestGames: [LiveGame] =  getMockGames()
    
    @Namespace var namespace
    @State var selectedGameId: Int?
    @State private var offset = CGSize.zero
    @State var selectedTab: StatsTabs = .hTeam
    var gameStats = getMockStats()
    @State var viewState = CGSize.zero
    
    
    
    // Add player of the day card flip animation
    func getLiveGames() async {
        let response = await network.getGames(date: "2023-01-28")
        liveGames = response
    }
    
    func getLatestGames() async {
        let response = await network.getLastWeekHistoryGames()
        latestGames = response
        dump(latestGames)
    }
    
    var body: some View {
        ZStack {
            if (selectedGameId == nil) {
                VStack {
                    Text("Live")
                        .customFont(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(liveGames, id: \.id) { game in
                                LiveGameCard(statsViewOpened: false, game: game)
                                    .matchedGeometryEffect(id: game.id, in: namespace)
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                            selectedGameId = game.id
                                        }
                                    }
                            }
                        }
                    }.task {
        //                await getLiveGames()
        //                await getLatestGames()
                    }
                    Text("Latest Games")
                        .customFont(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(latestGames, id: \.id) { game in
                                RecentGameCard(game: game)
                            }
                        }
                        
                    }
                    Spacer()
                }
                .padding(20)
                .padding(.top, 50)
            } else {
                VStack {
                    LiveGameCard(statsViewOpened: true, game: getMockGames()[2])
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                selectedGameId = nil
                            }
                        }
                        .matchedGeometryEffect(id: selectedGameId, in: namespace)
                    VStack {
                        HStack {
                            Text("NETS")
                                .frame(width: .infinity, height: 36)
                                .opacity(selectedTab == .hTeam ? 1 : 0.5)
                                .background(
                                    VStack {
                                        RoundedRectangle(cornerRadius: 2)
                                            .fill(.red)
                                            .frame(width: selectedTab == .hTeam ? 100 : 0, height: 2)
                                            .offset(y: 35)
                                            .opacity(selectedTab == .hTeam ? 1 : 0)
                                        Spacer()
                                    }
                                )
                                .onTapGesture {
                                    withAnimation {
                                        selectedTab = .hTeam
                                    }
                                }
                            Spacer()
                            Text("BUCKS")
                                .frame(width: .infinity, height: 36)
                                .opacity(selectedTab == .vTeam ? 1 : 0.5)
                                .background(
                                    VStack {
                                        RoundedRectangle(cornerRadius: 2)
                                            .fill(.red)
                                            .frame(width: selectedTab == .vTeam ? 100 : 0, height: 2)
                                            .offset(y: 35)
                                            .opacity(selectedTab == .vTeam ? 1 : 0)
                                        Spacer()
                                    }
                                )
                                .onTapGesture {
                                    withAnimation {
                                        selectedTab = .vTeam
                                    }
                                }
                            Spacer()
                            Text("STATS")
                                .frame(width: .infinity, height: 36)
                                .opacity(selectedTab == .stats ? 1 : 0.5)
                                .background(
                                    VStack {
                                        RoundedRectangle(cornerRadius: 2)
                                            .fill(.red)
                                            .frame(width: selectedTab == .stats ? 100 : 0, height: 2)
                                            .offset(y: 35)
                                            .opacity(selectedTab == .stats ? 1 : 0)
                                        Spacer()
                                    }
                                )
                                .onTapGesture {
                                    withAnimation {
                                        selectedTab = .stats
                                    }
                                }
                        }
                        TabView {
                            switch selectedTab {
                            case .hTeam:
                                PlayerStatsTable(players: getMockPlayers())
                            case .vTeam:
                                PlayerStatsTable(players: getMockPlayers())
                            case .stats:
                                StatsTable(homeLogo: gameStats[0].team.logo, visitorLogo: gameStats[1].team.logo, homeStats: gameStats[0].statistics[0], visitorStats: gameStats[1].statistics[0])
                            }
                        }
                        .tabViewStyle(.page)
                        .disabled(true)
                        
                    }
                    .padding(20)
                }
                .offset(x: viewState.width, y: viewState.height)
                .gesture(
                    DragGesture().onChanged { value in
                        viewState = value.translation
                    }
                    .onEnded { value in
//                        if (value.location.y - value.startLocation.y) > 0 {
//                            print("Down")
//                        } else {
//                            print("Up")
//                        }
                        withAnimation {
                            selectedGameId = nil
                        }
                        viewState = .zero
                    }
                )
            }
        }
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Network())
    }
}
