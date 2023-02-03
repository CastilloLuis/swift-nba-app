//
//  PlayerStatsTable.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/2/23.
//

import SwiftUI

struct PlayerStatsTable: View {
    var players: [PlayerData] = getMockPlayers()
    
    var body: some View {
        VStack {
            HStack {
                Text("Player")
                Spacer()
                Text("Min").frame(width: 30)
                Text("Reb").frame(width: 30)
                Text("Ast").frame(width: 30)
                Text("Pts").frame(width: 30)
            }
            Divider()
            ScrollView {
                ForEach(players.filter { $0.pos != nil}, id: \.player.id) { player in
                    HStack {
                        Text("\(player.pos!)  -")
                        Text("\(player.player.firstname!) \(player.player.lastname!)")
                        Spacer()
                        Text("\(player.min ?? "0")").frame(width: 50)
                        Text("\(player.totReb ?? 0)").frame(width: 30)
                        Text("\(player.assists ?? 0)").frame(width: 30)
                        Text("\(player.points ?? 0)").frame(width: 30)
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
