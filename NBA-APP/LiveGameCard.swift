//
//  LiveGameCard.swift
//  NBA-APP
//
//  Created by Luis Castillo on 1/31/23.
//

import SwiftUI

struct LiveGameCard: View {
    var statsViewOpened: Bool
    var game: LiveGame
    var testLogo: String = "https://upload.wikimedia.org/wikipedia/fr/thumb/f/f3/Hornets_de_Charlotte_logo.svg/1200px-Hornets_de_Charlotte_logo.svg.png"
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(game.teams?.home.nickname ?? "-")
                        .customFont(.footnote)
                    Text("\(game.scores?.home.points ?? 0)").font(
                        .custom("Poppins Bold", size: 40)
                    )
                }
                .overlay {
                    VStack {
                        AsyncImage(url: URL(string: game.teams?.home.logo ?? testLogo)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                            
                        } placeholder: {
                            //put your placeholder here
                        }
                    }
                    .frame(width: statsViewOpened ? 80 : 120, height: statsViewOpened ? 80 : 120)
                    .position(x: -65, y: 40)
                }
                
                Text("vs")
                    .padding(.top, 10)
                    .opacity(0.7)
                
                VStack {
                    Text(game.teams?.visitors.nickname ?? "-")
                        .customFont(.footnote)
                    Text("\(game.scores?.visitors.points ?? 0)").font(
                        .custom("Poppins Bold", size: 40)
                    )
                }
                .overlay {
                    VStack {
                        AsyncImage(url: URL(string: game.teams?.visitors.logo ?? testLogo)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            //put your placeholder here
                        }
                    }
                    .frame(width: statsViewOpened ? 80 : 120, height: statsViewOpened ? 80 : 120)
                    .position(x: 125, y: 40)
                }
            }
            .overlay {
                HStack {
                    switch game.status?.short {
                        case 1:
                            Text("SOON").customFont(.footnote2)
                        case 2:
                            Circle().fill(.red)
                            .frame(width: 8, height: 8)
                            .overlay {
                                Circle().fill(.red.opacity(0.5))
                                    .frame(width: 15, height: 15)
                            }
                            Text("LIVE").customFont(.footnote2)
                            Text("\(game.periods?.current ?? 0)/4").customFont(.footnote2)
                        case 3:
                            Text("FINAL").customFont(.footnote2)
                        default:
                            Text("-")
                    }
                }
                .padding(.top, 80)
            }
        }
        .modifier(
            CustomFrameModifier(open: statsViewOpened, width: statsViewOpened ? .infinity : 330, height: statsViewOpened ? 250 : 120)
        )
        .background(
            Image("stadium")
                .resizable()
                .frame(maxWidth: .infinity)
                .overlay {
                    Rectangle()
                        .fill(
                            .linearGradient(colors: [Color(hex: "8e9eab"), Color(hex: "eef2f3")], startPoint: .top, endPoint: .bottom)
                        )
                        .opacity(0.9)
                }
        )
        .cornerRadius(statsViewOpened ? 20 : 25, corners: .bottomLeft)
        .cornerRadius(statsViewOpened ? 20 : 25, corners: .bottomRight)
        .cornerRadius(statsViewOpened ? 0 : 25, corners: .allCorners)
    }
}

struct LiveGameCard_Previews: PreviewProvider {
    static var previews: some View {
        LiveGameCard(statsViewOpened: false, game: getMockGames()[0])
    }
}
