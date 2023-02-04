//
//  SummaryTable.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/4/23.
//

import SwiftUI

struct SummaryTable: View {
    var topPerformers: [PlayerData] = []
    
    func sumTotalPoints(points: [String]) -> String {
        if (points.count == 0) { return "-" }
        let _points = points.map { p in Int(p) }
        let totalSum = _points.reduce(0, { x, y in
            x + (y ?? 0)
        })
        return "\(totalSum)"
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("game summary".uppercased())
                    .customFont(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 20)
                HStack {
                    Rectangle().fill(.black.opacity(0)).frame(width: 50, height: 50)
                    ForEach([1, 2, 3, 4], id: \.self) { lineScore in
                        Text("Q\(lineScore)".uppercased())
                            .customFont(.footnote)
                            .foregroundColor(.black.opacity(0.7))
                            .frame(maxWidth: .infinity, maxHeight: 36)
                    }
                    Text("T")
                        .customFont(.footnote)
                        .foregroundColor(.black.opacity(0.7))
                        .frame(maxWidth: .infinity, maxHeight: 36)
                }
                .frame(height: 10)
                Divider()
                    .frame(height: 1)
                HStack {
                    AsyncImage(url: URL(string: getMockStats()[0].team.logo)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        //put your placeholder here
                    }
                    .frame(maxWidth: .infinity, maxHeight: 36)
                    ForEach(getMockGames()[0].scores?.home.linescore ?? [], id: \.self) { lineScore in
                        Text("\(lineScore)")
                            .customFont(.footnote)
                            .frame(maxWidth: .infinity, maxHeight: 36)
                    }
                    Text(sumTotalPoints(points: getMockGames()[0].scores?.home.linescore ?? []))
                        .customFont(.headline)
                        .frame(maxWidth: .infinity, maxHeight: 36)
                }
                Divider()
                    .frame(height: 1)
                HStack {
                    AsyncImage(url: URL(string: getMockStats()[1].team.logo)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        //put your placeholder here
                    }
                    .frame(maxWidth: .infinity, maxHeight: 36)
                    ForEach(getMockGames()[0].scores?.visitors.linescore ?? [], id: \.self) { lineScore in
                        Text("\(lineScore)")
                            .customFont(.footnote)
                            .frame(maxWidth: .infinity, maxHeight: 36)
                    }
                    Text(sumTotalPoints(points: getMockGames()[0].scores?.visitors.linescore ?? []))
                        .customFont(.headline)
                        .frame(maxWidth: .infinity, maxHeight: 36)
                }
            }
            .padding(.bottom, 30)
            VStack {
                Text("top performers".uppercased())
                    .customFont(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 20)
                
                    ForEach(topPerformers, id: \.player.id) { player in
                        HStack {
                            VStack {
                                Text("\(player.player.firstname ?? "-") \(player.player.lastname ?? "-")")
                                    .customFont(.caption)
                                Text("\(player.team.code)" + " - " + "\(player.pos ?? "")")
                                    .customFont(.caption)
                                    .foregroundColor(.black.opacity(0.5))
                            }
                            .frame(width: 100)
                            .multilineTextAlignment(.center)
                            Spacer()
                            VStack {
                                Text("\(player.points ?? 0)")
                                    .customFont(.title3)
                                Text("PTS").customFont(.footnote)
                            }
                            Spacer()
                            VStack {
                                Text("\(player.totReb ?? 0)")
                                    .customFont(.title3)
                                Text("REB").customFont(.footnote)
                            }
                            Spacer()
                            VStack {
                                Text("\(player.assists ?? 0)")
                                    .customFont(.title3)
                                Text("AST").customFont(.footnote)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        Divider()
                    }
            }
            
            Spacer()
        }
    }
}

struct SummaryTable_Previews: PreviewProvider {
    static var previews: some View {
        SummaryTable()
    }
}
