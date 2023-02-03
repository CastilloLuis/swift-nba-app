//
//  GameStatsView.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/2/23.
//

import SwiftUI

struct GameStatsView: View {
    @Namespace var namespace
    @State var show = false
    @State private var offset = CGSize.zero
    var gameStats = getMockStats()
    
    var body: some View {
        ZStack {
            if (!show) {
                VStack(alignment: .leading, spacing: 12) {
                    LiveGameCard(statsViewOpened: false, game: getMockGames()[2])
                        .matchedGeometryEffect(id: "liveGameCard", in: namespace)
                }
            } else {
                VStack(alignment: .leading, spacing: 0) {
                    LiveGameCard(statsViewOpened: true, game: getMockGames()[2])
                        .matchedGeometryEffect(id: "liveGameCard", in: namespace)
                    VStack {
                        TabView {
                            PlayerStatsTable(players: getMockPlayers())
                            StatsTable(homeLogo: gameStats[0].team.logo, visitorLogo: gameStats[1].team.logo, homeStats: gameStats[0].statistics[0], visitorStats: gameStats[1].statistics[0])
                        }
                        .tabViewStyle(.page)
                        
                    }
                    .padding(20)
                }
            }
        }
        .ignoresSafeArea()
        .onTapGesture {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                show.toggle()
            }
        }
    }
}

struct GameStatsView_Previews: PreviewProvider {
    static var previews: some View {
        GameStatsView()
    }
}
