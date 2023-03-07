//
//  GameDetailView.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/11/23.
//

import SwiftUI
import ActivityKit

struct GameDetailView: View {
    @EnvironmentObject var network: Network
    @Binding var gameId: Int?
    @State var selectedGame: LiveGame?
    @State var selectedGameStats: [GameStats]?
    @State var loading = true
    @State var tracking = false
    
    func startLiveActivity(game: LiveGame) async {
        let attributes = ScoresAttributes(game: game)
        let state = ScoresAttributes.ContentState(
            homeScore: (game.scores?.home.points)!,
            visitorScore: (game.scores?.visitors.points)!,
            time: "\(game.periods?.current ?? 0)/4"
        )
        
        // Starting Activity & Content
        let activityContent = ActivityContent(state: state, staleDate: Calendar.current.date(byAdding: .hour, value: 3, to: Date())!)
        let finalActivityStatus = ScoresAttributes.ScoresTrackingStatus(
            homeScore: (game.scores?.home.points)!,
            visitorScore: (game.scores?.visitors.points)!,
            time: "\(game.periods?.current ?? 0)/4"
        )
        let finalContent = ActivityContent(state: finalActivityStatus, staleDate: nil)
        
        do {
            for activity in Activity<ScoresAttributes>.activities {
                await activity.end(finalContent, dismissalPolicy: .default)
                print("Ending the stack Live Activity: \(activity.id)")
            }
            let myActivity = try Activity<ScoresAttributes>.request(attributes: attributes, content: activityContent)
            print("Starting new Live Activity: \(myActivity.id)")
            withAnimation {
                tracking = true
            }
        } catch {
            print("Error!")
        }
    }
    
    var body: some View {
        VStack {
            if (!loading) {
                LiveGameCard(statsViewOpened: true, game: selectedGame!)
                GameStatsView(gameStats: selectedGameStats, game: selectedGame)
                if (tracking) {
                    HStack {
                        Text("Tracking")
                            .customFont(.title4)
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                    }
                    .padding(.top, -50)
                } else {
                    Button {
                        Task {
                            await startLiveActivity(game: selectedGame!)
                        }
                    } label: {
                        HStack {
                            Image(systemName: "basketball")
                            Text("track game".uppercased())
                                .customFont(.title3)
                            Image(systemName: "basketball")
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        Rectangle()
                            .fill(
                                .linearGradient(colors: [Color(hex: "#232526"), Color(hex: "#414345").opacity(0.9)], startPoint: .top, endPoint: .bottom)
                            )
                            .opacity(0.9)
                    )
                    .cornerRadius(25, corners: .allCorners)
                    .padding(15)
                }
            }
        }
        .task {
            loading = true
            let game = await network.getGamePerId(gameId: gameId!)
            let stats = await network.getGameStats(gameId: gameId!)
            selectedGame = game[0]
            selectedGameStats = stats
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
