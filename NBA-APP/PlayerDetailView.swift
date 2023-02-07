//
//  PlayerDetailView.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/7/23.
//

import SwiftUI

struct PlayerDetailView: View {
    var player: PlayerSportsIo
    var team: TeamSportsIo?
    
    init() {
        player  = getMockPlayerSports()[20]
        let teams = getAllTeamsSports()
        let p = teams.filter {team in
            team.key?.lowercased() == player.team?.lowercased()
        }[0]
        print(p)
        team = p
    }
    
    func calculateAge(_ dateStr: String) -> String {
        let today = Date.now
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
        guard let date = dateFormatter.date(from: dateStr) else {
           return  "18"
        }
        
        dateFormatter.dateFormat = "yyyy"
        let todayYear = dateFormatter.string(from: today)
        let birthdayYear = dateFormatter.string(from: date)

        let age = Int(todayYear)! - Int(birthdayYear)!
        
        return String(age)
    }
    
    func dateToHuman(_ dateStr: String) -> String {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let formattedBirthdayDate = dateFormatter.date(from: dateStr) else { return "-" }
        
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
        return dateFormatter.string(from: formattedBirthdayDate)
    }
    
    func getPlayerHeadshot(_ playerId: Int) -> String {
        return "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/\(playerId).png"
    }
    
    func getTeamPngLogo(_ teamCode: String) -> String {
        return "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/\(teamCode).png"
    }
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: getPlayerHeadshot(player.nbaDotCOMPlayerID ?? 2222))) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    //put your placeholder here
                }
                .frame(width: 200)
                .padding(.bottom, -64)
                VStack {
                    Text("\(player.team ?? "-") | #\(player.jersey ?? 1) | \(player.position ?? "-")")
                        .customFont(.subheadline)
                    Text(player.fantasyDraftName ?? "-")
                        .customFont(.title3)
                }
                .foregroundColor(Color(hex: team?.tertiaryColor ?? "FFFFFF"))
                .frame(alignment: .leading)
                .padding(.bottom, -40)
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: 210)
            .background(
                ZStack {
                    Spacer()
                    AsyncImage(url: URL(string: getTeamPngLogo(player.team ?? "lal") )) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        //put your placeholder here
                    }
                    .frame(width: 200)
                    .opacity(0.3)
                    AsyncImage(url: URL(string: getTeamPngLogo(player.team ?? "lal") )) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        //put your placeholder here
                    }
                    .frame(width: 50)
                    .position(x: 50, y: 50)
                }
                .frame(maxWidth: .infinity, maxHeight: 210)
                .background(Color(hex: team?.primaryColor ?? "FFFFFF"))
            )
            
            
            VStack {
                HStack {
                    VStack {
                        Text("body".uppercased())
                            .customFont(.footnote)
                            .foregroundColor(.black.opacity(0.7))
                        HStack {
                            Text("\(player.height ?? 0) kg -")
                            Text(String(Float(Float(player.weight!)/Float(100))) + " m")
                            if let b = player.birthDate {
                                Text("- \(calculateAge(b)) years")
                            }
                        }
                        .customFont(.subheadline)
                    }.frame(maxWidth: .infinity)
                    Spacer()
                    VStack {
                        Text("experience".uppercased())
                            .customFont(.footnote)
                            .foregroundColor(.black.opacity(0.7))
                        HStack {
                            Text("\(player.experience ?? 0) years")
                        }
                        .customFont(.subheadline)
                    }.frame(maxWidth: .infinity)
                }
                Divider()
                HStack {
                    VStack {
                        Text("college".uppercased())
                            .customFont(.footnote)
                            .foregroundColor(.black.opacity(0.7))
                        HStack {
                            Text(player.college!)
                        }
                        .customFont(.subheadline)
                    }.frame(maxWidth: .infinity)
                    Spacer()
                    VStack {
                        Text("COUNTRY".uppercased())
                            .customFont(.footnote)
                            .foregroundColor(.black.opacity(0.7))
                        HStack {
                            Text(player.birthCountry!)
                        }
                        .customFont(.subheadline)
                    }.frame(maxWidth: .infinity)
                }
                Divider()
                HStack {
                    VStack {
                        Text("birthday".uppercased())
                            .customFont(.footnote)
                            .foregroundColor(.black.opacity(0.7))
                        HStack {
                            Text(dateToHuman(player.birthDate!))
                        }
                        .customFont(.subheadline)
                    }.frame(maxWidth: .infinity)
                    Spacer()
                    VStack {
                        Text("salary".uppercased())
                            .customFont(.footnote)
                            .foregroundColor(.black.opacity(0.7))
                        HStack {
                            Text("\(player.salary ?? 0)".toCurrencyFormat())
                        }
                        .customFont(.subheadline)
                    }.frame(maxWidth: .infinity)
                }
                Divider()
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            
            Button {
                print("Following up")
            } label: {
                Image(systemName: "heart")
                Text("Follow")
            }
            
            
            NewsSlider(label: "Player News")
            Spacer()
        }
    }
}

struct PlayerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailView()
    }
}
