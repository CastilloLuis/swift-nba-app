//
//  HomeView.swift
//  NBA-APP
//
//  Created by Luis Castillo on 1/31/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var network: Network
    @State var liveGames: [LiveGame] = getMockGames()
    @State var latestGames: [LiveGame] =  getMockGames()
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
        VStack(alignment: .leading) {
            Text("Live")
                .customFont(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(liveGames, id: \.id) { game in
                        LiveGameCard(game: game)
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(20)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Network())
    }
}
