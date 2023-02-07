//
//  News.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/6/23.
//

import Foundation

struct News: Codable {
    let newsID: Int
    let source, updated, timeAgo, title: String
    let content: String
    let url: String
    let termsOfUse, author, categories: String
    let playerID, teamID: Int
    let team: String
    let playerID2: Int?
    let teamID2: Int?
    let team2: String?
    let originalSource: String
    let originalSourceURL: String

    enum CodingKeys: String, CodingKey {
        case newsID = "NewsID"
        case source = "Source"
        case updated = "Updated"
        case timeAgo = "TimeAgo"
        case title = "Title"
        case content = "Content"
        case url = "Url"
        case termsOfUse = "TermsOfUse"
        case author = "Author"
        case categories = "Categories"
        case playerID = "PlayerID"
        case teamID = "TeamID"
        case team = "Team"
        case playerID2 = "PlayerID2"
        case teamID2 = "TeamID2"
        case team2 = "Team2"
        case originalSource = "OriginalSource"
        case originalSourceURL = "OriginalSourceUrl"
    }
}

