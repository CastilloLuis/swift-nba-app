//
//  PlayerStatsTable.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/2/23.
//

import SwiftUI

var statsTitle = ["min", "reb", "ast", "pts"]

struct PlayerStatsTable: View {
    var players: [PlayerData] = getMockPlayers()
    
    var body: some View {
        VStack {
            HStack {
                Text("Player").customFont(.footnote2)
                Spacer()
                ForEach(statsTitle, id: \.self) { title in
                    Text(title.uppercased())
                        .customFont(.footnote2).frame(width: 35)
                }
            }
            Divider()
            ScrollView {
                ForEach(players.filter { $0.pos != nil}, id: \.player.id) { player in
                    HStack {
                        Text("\(player.pos!)  -").customFont(.footnote)
                        Text("\(player.player.firstname!) \(player.player.lastname!)").customFont(.footnote)
                        Spacer()
                        Text("\(player.min ?? "0")").customFont(.footnote).frame(width: 50)
                        Text("\(player.totReb ?? 0)").customFont(.footnote).frame(width: 30)
                        Text("\(player.assists ?? 0)").customFont(.footnote).frame(width: 30)
                        Text("\(player.points ?? 0)").customFont(.footnote).frame(width: 30)
                    }
                    Divider().opacity(0.5)
                }
            }
        }
        .background(.white)
    }
}

struct PlayerStatsTable_Previews: PreviewProvider {
    static var previews: some View {
        PlayerStatsTable(players: getMockPlayers())
    }
}
