//
//  GameStatsView.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/2/23.
//

import SwiftUI

struct StatsTab {
    let type: StatsTabsTypes
    let label: String
}

enum StatsTabsTypes {
    case players, stats, summary
}

var statisticsTabs = [
    StatsTab(type: .summary, label: "Summary"),
    StatsTab(type: .players, label: "Players"),
    StatsTab(type: .stats, label: "Statistics"),
]


struct GameStatsView: View {
    var network = Network()
    @State var selectedTab: StatsTab = statisticsTabs[0]
    @State var selectedTeamTab: PillSelectionTabs?
    @State var topPerformers: [PlayerData] = []
    
    var gameStats = getMockStats()
    
    func getTopPerformers() async {
        let teams = await network.getPlayersStatsPerGame(gameId: 0)
        let teamsKeys = Array(teams.keys)
        topPerformers = []
        print(teamsKeys)
        for key in teamsKeys {
            let player = teams[key]?.max{a, b in a.points! < b.points!}
            if let p = player {
                topPerformers.append(p)
            }
        }
    }
    
    var body: some View {
        VStack {
            GameStatsTabs()
        
            if (selectedTab.type == StatsTabsTypes.players) {
                VStack {
                    PillSelection(
                        tabs: [
                            PillSelectionTabs(label: "Heat"),
                            PillSelectionTabs(label: "Nets")
                        ]
                    ) { item in selectedTeamTab = item }
                    Divider().padding(.top, 10)
                }.padding(.bottom, 10)
            }
                switch selectedTab.type {
                    case .summary:
                    SummaryTable(topPerformers: topPerformers)
                    case .players:
                        PlayerStatsTable(players: getMockPlayers())
                    case .stats:
                        StatsTable(homeLogo: gameStats[0].team.logo, visitorLogo: gameStats[1].team.logo, homeStats: gameStats[0].statistics[0], visitorStats: gameStats[1].statistics[0])
                }
        }
        .padding(.horizontal, 20)
        .background(.white)
    }
    
    func GameStatsTabs() -> some View {
        return VStack {
            HStack {
                Spacer()
                
                ForEach(statisticsTabs, id: \.type) { tab in
                    Text(tab.label)
                        .customFont(.title4)
                        .frame(maxWidth: .infinity, maxHeight: 46)
                        .opacity(selectedTab.type == tab.type ? 1 : 0.5)
                        .onTapGesture {
                            withAnimation {
                                selectedTab = tab
                            }
                        }
                        .background(
                            Rectangle()
                                .fill(Color.white)
                                .padding(.bottom, 1)
                                .background(Color(hex: "#FFD200").opacity(selectedTab.type == tab.type ? 1: 0))
                        )
                        .task {
                            await getTopPerformers()
                        }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            Rectangle()
                .fill(.black.opacity(0.1))
                .frame(height: 1)
                .padding(.top, -9)
                .padding(.horizontal, 7)
        }
    }
}

struct GameStatsView_Previews: PreviewProvider {
    static var previews: some View {
        GameStatsView(network: Network())
    }
}
