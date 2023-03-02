//
//  TeamsListView.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/18/23.
//

import SwiftUI

let DEFAULT_TEAM_COLOR = "FFFFFF"

struct TeamsListView: View {
    @State var teams: [TeamSportsIo] = getAllTeamsSports()
    @State var followingTeams: [TeamSportsIo] = []
    @AppStorage("FOLLOWING_TEAMS") var followingTeamsId: String = "[]"
    
    func getTeamColor(_ team: TeamSportsIo) -> String {
        if (team.secondaryColor == nil || team.secondaryColor == DEFAULT_TEAM_COLOR) {
            return team.primaryColor  ?? team.tertiaryColor ?? DEFAULT_TEAM_COLOR
        }
        return team.secondaryColor ?? team.tertiaryColor ?? DEFAULT_TEAM_COLOR
    }
    
    // Create helper because this fn is being shared between PlayerDetail and this view
    func getTeamPngLogo(_ teamCode: String) -> String {
        return "https://a.espncdn.com/combiner/i?img=/i/teamlogos/nba/500/\(teamCode).png"
    }
    
    func parseFolowingTeams() -> [Int] {
        do {
            let followingTeamsJson = followingTeamsId.data(using: .utf8)!
            let followingTeamsParsed = try JSONDecoder().decode([Int].self, from: followingTeamsJson)
            return followingTeamsParsed
        } catch {
            print("Error while parsing following teams ids")
            return []
        }
    }
    
    func followTeam(_ teamId: Int) {
        var teamsId = parseFolowingTeams()
        teamsId.append(teamId)
        followingTeamsId = teamsId.description
        filterFollowingTeams()
    }
    
    func filterFollowingTeams() {
        let teamsId = parseFolowingTeams()
        for teamId in teamsId {
            let result: [TeamSportsIo] = teams.filter{ team in team.teamID == teamId }
            if (result.count > 0) {
                teams = teams.filter { team in
                    team.teamID != teamId
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        followingTeams.append(result[0])
                    }
                }
            }

        }
    }
    
    var body: some View {
        List {
            if (followingTeams.count > 0) {
                Section.init {
                    Text("Following")
                        .customFont(.title2)
                        .listRowSeparator(.hidden)
                        .padding(.bottom, 20)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(alignment: .top) {
                            ForEach(followingTeams, id: \.teamID) { team in
                                VStack {
                                    AsyncImage(url: URL(string: getTeamPngLogo(team.key?.lowercased() ?? "lal") )) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        //put your placeholder here
                                    }
                                }
                                .padding(15)
                                .frame(width: 80, height: 80)
                                .background(Color(hex: getTeamColor(team)))
                                .clipShape(Circle())
                                .overlay(
                                    ZStack {
                                        Image(systemName: "checkmark.circle.fill")
                                            .scaledToFit()
                                    }
                                    .background(.white)
                                    .clipShape(Circle())
                                    .frame(width: 50, height: 50)
                                    .position(x: 70, y: 10)
                                )
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listRowInsets(EdgeInsets())
            }
            Text("Teams")
                .customFont(.title2)
                .listRowSeparator(.hidden)
                .padding(.leading, -20)
            ForEach(teams, id: \.teamID) { team in
                HStack {
                    Text(team.name!)
                        .customFont(.title)
                        .foregroundColor(.white)
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .background(Color(hex: getTeamColor(team)))
                .cornerRadius(15, corners: .allCorners)
                .overlay(
                    ZStack {
                        AsyncImage(url: URL(string: getTeamPngLogo(team.key?.lowercased() ?? "lal") )) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            //put your placeholder here
                        }
                        .frame(width: .infinity, height: .infinity)
                    }
                    .padding()
                    .position(x: 60, y: 50)
                )
                .swipeActions(allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        print("Adding to favorite")
                        followTeam(team.teamID!)
                    } label: {
                        Image(systemName: "star")
                    }
                    .tint(.orange)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(
                    EdgeInsets(
                        top: 5,
                        leading: 0,
                        bottom: 5,
                        trailing: 0
                    )
                )
            }
        }
        .scrollContentBackground(.hidden)
        .onAppear {
            followingTeamsId = "[]"
        }
    }
}

struct TeamsListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsListView()
    }
}
