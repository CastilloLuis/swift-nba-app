//
//  StatsTable.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/2/23.
//

import SwiftUI

struct StatsTable: View {
    var homeLogo: String
    var visitorLogo: String
    var homeStats: Statistic
    var visitorStats: Statistic
    
    func HorizontalStat(_ hStat: Int, _ vStat: Int, _ label: String) -> some View {
        return VStack{
            HStack {
                Text("\(hStat)").customFont(.footnote2)
                Spacer()
                Text(label.uppercased()).customFont(.footnote)
                Spacer()
                Text("\(vStat)").customFont(.footnote2)
            }
            .frame(height: 30)
            Divider()
        }
    }

    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: homeLogo)) { image in
                    image
                        .resizable()
                        .frame(width: 30, height: 30)
                } placeholder: {
                    //put your placeholder here
                }
                
                Spacer()
                Text("game stats".uppercased())
                    .customFont(.title3)
                Spacer()
                
                AsyncImage(url: URL(string: visitorLogo)) { image in
                    image
                        .resizable()
                        .frame(width: 30, height: 30)
                } placeholder: {
                    //put your placeholder here
                }
            }
            .frame(maxWidth: .infinity)
            ScrollView {
                VStack {
                        HorizontalStat(homeStats.points, visitorStats.points, "Points")
                        HorizontalStat(homeStats.pointsInPaint, visitorStats.pointsInPaint, "Points in the paint")
                        HorizontalStat(homeStats.steals, visitorStats.steals, "Steals")
                        HorizontalStat(homeStats.fga, visitorStats.fga, "FGA")
                        HorizontalStat(homeStats.offReb, visitorStats.offReb, "Offense REB")
                        HorizontalStat(homeStats.defReb, visitorStats.defReb, "Defense REB")
                        HorizontalStat(homeStats.assists, visitorStats.assists, "Assists")
                        HorizontalStat(homeStats.pFouls, visitorStats.pFouls, "Fouls")
                        HorizontalStat(homeStats.turnovers, visitorStats.turnovers, "Turnovers")
                        HorizontalStat(homeStats.blocks, visitorStats.blocks, "Blocks")
                }
                .frame(maxWidth: .infinity)
            }
        }
        .background(.white)
    }
}

struct StatsTable_Previews: PreviewProvider {
    static var previews: some View {
        StatsTable(homeLogo: getMockStats()[0].team.logo, visitorLogo: getMockStats()[0].team.logo, homeStats: getMockStats()[0].statistics[0], visitorStats: getMockStats()[1].statistics[0])
    }
}
