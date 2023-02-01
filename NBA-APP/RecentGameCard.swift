//
//  RecentGameCard.swift
//  NBA-APP
//
//  Created by Luis Castillo on 1/31/23.
//

import SwiftUI

struct RecentGameCard: View {
    let game: LiveGame
    let testLogo =  "https://upload.wikimedia.org/wikipedia/fr/thumb/f/f3/Hornets_de_Charlotte_logo.svg/1200px-Hornets_de_Charlotte_logo.svg.png"
    
    var body: some View {
            VStack(alignment: .leading) {
                Spacer()
                HStack(spacing: 10) {
                    VStack {
                        AsyncImage(url: URL(string: game.teams?.home.logo ?? testLogo)) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            //put your placeholder here
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Text("vs").customFont(.footnote)
                    VStack {
                        AsyncImage(url: URL(string: game.teams?.visitors.logo ?? testLogo)) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            //put your placeholder here
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                Spacer()
                HStack {
                    Text(game.teams?.home.nickname ?? "-").customFont(.title3)
                    Spacer()
                    Text("\(game.scores?.home.points ?? 0)").customFont(.title)
                }
                .frame(maxWidth: .infinity)
                HStack {
                    Text(game.teams?.visitors.nickname ?? "-").customFont(.title3)
                    Spacer()
                    Text("\(game.scores?.visitors.points ?? 0)").customFont(.title)
                }
                .frame(maxWidth: .infinity)
                Spacer()
                Text(game.date?.start.components(separatedBy: "T")[0] ?? "-").customFont(.footnote2)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(20)
            .frame(width: 250, height: 260)
            .background(
                .linearGradient(colors: [Color(hex: "8e9eab"), Color(hex: "eef2f3")], startPoint: .top, endPoint: .bottom)
            )
            .mask(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
            )
    }
}

struct RecentGameCard_Previews: PreviewProvider {
    static var previews: some View {
        RecentGameCard(game: getMockGames()[1])
    }
}
