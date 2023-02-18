//
//  PlayerDetailView.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/7/23.
//

import SwiftUI

struct PlayerDetailView: View {
    @EnvironmentObject var network: Network
    
    @Binding var player: PlayerSportsIo
    @State var team: TeamSportsIo?
    @State var news: [News] = []
    
    func getSelectedTeam() {
        let teams = getAllTeamsSports()
        team = teams.filter { team in
            team.key?.lowercased() == player.team?.lowercased()
        }[0]
    }
    
    func getPlayerHeadshot(_ playerId: Int) -> String {
        return "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/\(playerId).png"
    }
    
    func getTeamPngLogo(_ teamCode: String) -> String {
        return "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/\(teamCode).png"
    }
    
    func getPlayerNews() async {
        guard let pId = player.playerID else { fatalError("Invalid Player Id") }
        news = await network.getNews(playerId: pId)
    }
    
    var body: some View {
        NavigationStack {
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
                .foregroundColor(Color(hex: "FFFFFF"))
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
                .background(.black.opacity(0.5))
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
                                Text("- \(Date().calculateAge(b)) years")
                            }
                        }
                        .customFont(.subheadline)
                    }.frame(maxWidth: .infinity)
                    Spacer()
                    DataItemRow(label: "experience", value: "\(player.experience ?? 0) years")
                }
                Divider()
                HStack {
                    DataItemRow(label: "college", value: player.college!)
                    Spacer()
                    DataItemRow(label: "country", value: player.birthCountry!)
                }
                Divider()
                HStack {
                    DataItemRow(label: "birthday", value: Date().dateToHuman(player.birthDate!))
                    Spacer()
                    DataItemRow(label: "salary", value: "\(player.salary ?? 0)".toCurrencyFormat())
                }
                Divider()
            }
            .padding(20)
            .frame(maxWidth: .infinity)

            
            NewsSlider(label: "Player News", news: $news)
            Spacer()
        }
        .task {
            getSelectedTeam()
            await getPlayerNews()
        }
    }
    
    func DataItemRow(label: String, value: String) -> some View {
        return VStack {
            Text(label.uppercased())
                .customFont(.footnote)
                .foregroundColor(.black.opacity(0.7))
            HStack {
                Text(value)
            }
            .customFont(.subheadline)
        }
        .frame(maxWidth: .infinity)
    }
}

struct PlayerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailView(player: .constant(getMockPlayerSports()[0]))
            .environmentObject(Network())
    }
}
