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

    func HorizontalStat(_ hStat: Int?, _ vStat: Int?, _ label: String) -> some View {
        return VStack{
            HStack {
                Text("\(hStat ?? 0)").customFont(.footnote2)
                Spacer()
                Text(label.uppercased()).customFont(.footnote)
                Spacer()
                Text("\(vStat ?? 0)").customFont(.footnote2)
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
                    if let hS = homeStats, let vS = visitorStats {
                        HorizontalStat(hS.points, vS.points, "Points")
                        HorizontalStat(hS.pointsInPaint, vS.pointsInPaint, "Points in the paint")
                        HorizontalStat(hS.steals, vS.steals, "Steals")
                        HorizontalStat(hS.fga, vS.fga, "FGA")
                        HorizontalStat(hS.offReb, vS.offReb, "Offense REB")
                        HorizontalStat(hS.defReb, vS.defReb, "Defense REB")
                        HorizontalStat(hS.assists, vS.assists, "Assists")
                        HorizontalStat(hS.pFouls, vS.pFouls, "Fouls")
                        HorizontalStat(hS.turnovers, vS.turnovers, "Turnovers")
                        HorizontalStat(hS.blocks, vS.blocks, "Blocks")
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .background(.white)
    }
}

struct StatsTable_Previews: PreviewProvider {
    static var previews: some View {
        StatsTable(
            homeLogo: "https://www.pngitem.com/pimgs/m/146-1462843_golden-state-logo-png-golden-state-warriors-new.png",
            visitorLogo: "https://www.pngitem.com/pimgs/m/146-1462843_golden-state-logo-png-golden-state-warriors-new.png",
            homeStats: (getMockStats()[0].statistics?[0])!,
            visitorStats: (getMockStats()[1].statistics?[0])!
        )
    }
}
