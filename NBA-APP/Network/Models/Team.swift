//
//  Team.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/7/23.
//

import Foundation

// MARK: - Welcome
struct TeamSportsIo: Codable {
    let teamID: Int?
    let key: String?
    let active: Bool?
    let city, name: String?
    let leagueID, stadiumID: Int?
    let conference, division, primaryColor, secondaryColor: String?
    let tertiaryColor, quaternaryColor: String?
    let wikipediaLogoURL: String?
    let wikipediaWordMarkURL: String?
    let globalTeamID, nbaDotCOMTeamID: Int?

    enum CodingKeys: String, CodingKey {
        case teamID = "TeamID"
        case key = "Key"
        case active = "Active"
        case city = "City"
        case name = "Name"
        case leagueID = "LeagueID"
        case stadiumID = "StadiumID"
        case conference = "Conference"
        case division = "Division"
        case primaryColor = "PrimaryColor"
        case secondaryColor = "SecondaryColor"
        case tertiaryColor = "TertiaryColor"
        case quaternaryColor = "QuaternaryColor"
        case wikipediaLogoURL = "WikipediaLogoUrl"
        case wikipediaWordMarkURL = "WikipediaWordMarkUrl"
        case globalTeamID = "GlobalTeamID"
        case nbaDotCOMTeamID = "NbaDotComTeamID"
    }
}
