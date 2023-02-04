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
                        .foregroundColor(.white)
                    Text("\(game.scores?.home.points ?? 0)").font(
                        .custom("Poppins Bold", size: 40)
                    )
                    .foregroundColor(.white)
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
                    .shadow(color: Color.white.opacity(0.3), radius: 10, x: 0, y: 0)
                }
                
                Text("vs")
                    .padding(.top, 10)
                    .opacity(0.7)
                    .foregroundColor(.white)
                
                VStack {
                    Text(game.teams?.visitors.nickname ?? "-")
                        .customFont(.footnote)
                        .foregroundColor(.white)
                    Text("\(game.scores?.visitors.points ?? 0)").font(
                        .custom("Poppins Bold", size: 40)
                    )
                    .foregroundColor(.white)
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
                    .shadow(color: Color.white.opacity(0.3), radius: 10, x: 0, y: 0)
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
                            Text("LIVE").customFont(.footnote2).foregroundColor(.white)
                            Text("\(game.periods?.current ?? 0)/4").customFont(.footnote2).foregroundColor(.white)
                        case 3:
                            Text("FINAL").customFont(.footnote2).foregroundColor(.white)
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
                            .linearGradient(colors: [Color(hex: "#232526"), Color(hex: "#414345").opacity(0.5)], startPoint: .top, endPoint: .bottom)
                        )
                        .opacity(0.9)
                }
        )
        .cornerRadius(statsViewOpened ? 45 : 25, corners: .bottomLeft)
        .cornerRadius(statsViewOpened ? 45 : 25, corners: .bottomRight)
        .cornerRadius(statsViewOpened ? 0 : 25, corners: .allCorners)
        .shadow(color: Color.black.opacity(statsViewOpened ? 0 : 0.5), radius: 10, x: 0, y: 0)
    }
}

struct LiveGameCard_Previews: PreviewProvider {
    static var previews: some View {
        LiveGameCard(statsViewOpened: false, game: getMockGames()[0])
    }
}
