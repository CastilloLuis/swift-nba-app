//
//  HomeView.swift
//  NBA-APP
//
//  Created by Luis Castillo on 1/31/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var network: Network
    @State var liveGames: [LiveGame] = []
    
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
                let response = await network.getGames(date: "2023-01-28")
                dump(response)
                liveGames = response
            }
            Text("Latest Games")
                .customFont(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    RecentGameCard()
                }
                
            }
        }
        .padding(20)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Network())
    }
}
