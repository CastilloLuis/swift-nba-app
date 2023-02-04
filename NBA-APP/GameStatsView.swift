//
//  GameStatsView.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/2/23.
//

import SwiftUI

struct GameStatsView: View {
    var network = Network()
    @State var selectedTab: StatsTabs = .summary
    @State var selectedTeamTab: TeamsTabs = .home
    @State var topPerformers: [PlayerData] = []
    
    var gameStats = getMockStats()
    
    func getTopPerformers() async {
        let teams = await network.getPlayersStatsPerGame(gameId: 0)
        let teamsKeys = Array(teams.keys)
        for key in teamsKeys {
            let player = teams[key]?.max{a, b in a.points! < b.points!}
            if let p = player {
                topPerformers.append(p)
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Summary")
                    .customFont(.headline)
                    .frame(maxWidth: .infinity, maxHeight: 46)
                    .opacity(selectedTab == .summary ? 1 : 0.5)
                    .onTapGesture {
                        withAnimation {
                            selectedTab = .summary
                        }
                    }
                    .background(
                        Rectangle()
                            .fill(Color.white)
                            .padding(.bottom, 1)
                            .background(Color(hex: "#FFD200").opacity(selectedTab == .summary ? 1: 0))
                    )
                    .task {
                        await getTopPerformers()
                    }
                Text("Players")
                    .customFont(.headline)
                    .frame(maxWidth: .infinity, maxHeight: 46)
                    .opacity(selectedTab == .players ? 1 : 0.5)
                    .onTapGesture {
                        withAnimation {
                            selectedTab = .players
                        }
                    }
                    .background(
                        Rectangle()
                            .fill(Color.white)
                            .padding(.bottom, 1)
                            .background(Color(hex: "#FFD200").opacity(selectedTab == .players ? 1: 0))
                    )
                Text("Statistics")
                    .customFont(.headline)
                    .frame(maxWidth: .infinity, maxHeight: 46)
                    .opacity(selectedTab == .stats ? 1 : 0.5)
                    .onTapGesture {
                        withAnimation {
                            selectedTab = .stats
                        }
                    }
                    .background(
                        Rectangle()
                            .fill(Color.white)
                            .padding(.bottom, 1)
                            .background(Color(hex: "#FFD200").opacity(selectedTab == .stats ? 1: 0))
                    )
                Spacer()
            }
            .frame(maxWidth: .infinity)
            Rectangle()
                .fill(.black.opacity(0.1))
                .frame(height: 1)
                .padding(.top, -9)
                .padding(.horizontal, 7)
            
            if (selectedTab == .players) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            .white
                        )
                        .frame(width: 122, height: 34)
                        .offset(x: selectedTeamTab == .home ? -60 : 60)
                        
                    HStack {
                        VStack {
                            Text("Cleveland")
                                .customFont(.footnote2)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                selectedTeamTab = .home
                            }
                        }
                        VStack {
                            Text("Bucks")
                                .customFont(.footnote2)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                selectedTeamTab = .visitor
                            }
                        }
                    }
                }
                .padding(.horizontal, 5)
                .frame(width: 250, height: 40)
                .background(
                    .linearGradient(colors: [Color(hex: "#F7971E"), Color(hex: "#FFD200")], startPoint: .topTrailing, endPoint: .bottomTrailing)
                )
                .cornerRadius(20, corners: .allCorners)
            }
            
            TabView {
                switch selectedTab {
                    case .summary:
                        SummaryTable(topPerformers: topPerformers)
                    case .players:
                        PlayerStatsTable(players: getMockPlayers())
                    case .stats:
                        StatsTable(homeLogo: gameStats[0].team.logo, visitorLogo: gameStats[1].team.logo, homeStats: gameStats[0].statistics[0], visitorStats: gameStats[1].statistics[0])
                }
            }
            .tabViewStyle(.page)
        }
        .padding(.horizontal, 20)
        .background(.white)
    }
}

struct GameStatsView_Previews: PreviewProvider {
    static var previews: some View {
        GameStatsView(network: Network())
    }
}


enum StatsTabs {
    case players, stats, summary
}

enum TeamsTabs {
    case home, visitor
}
