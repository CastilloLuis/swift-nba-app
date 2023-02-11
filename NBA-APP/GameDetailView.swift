//
//  GameDetailView.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/11/23.
//

import SwiftUI

struct GameDetailView: View {
    @EnvironmentObject var network: Network
    @Binding var gameId: Int?
    @State var selectedGame: LiveGame?
    @State var selectedGameStats: [GameStats]?
    @State var loading = true
    
    var body: some View {
        VStack {
            if (!loading) {
                LiveGameCard(statsViewOpened: true, game: selectedGame!)
                GameStatsView(gameStats: selectedGameStats, game: selectedGame)
            }
        }
        .task {
            loading = true
            let game = await network.getGamePerId(gameId: gameId!)
            let stats = await network.getGameStats(gameId: gameId!)
            selectedGame = game[0]
            selectedGameStats = stats
            print(selectedGameStats)
            loading = false
        }
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(gameId: .constant(1), selectedGame: getMockGames()[3])
            .environmentObject(Network())
    }
}
