//
//  Player.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/2/23.
//

import Foundation

// MARK: - PlayerData
struct PlayerData: Codable {
    let player: Player
    let team: Team
    let game: Game
    let points: Int?
    let pos, min: String?
    let fgm, fga: Int?
    let fgp: String?
    let ftm, fta: Int?
    let ftp: String?
    let tpm, tpa: Int?
    let tpp: String?
    let offReb, defReb, totReb, assists: Int?
    let pFouls, steals, turnovers, blocks: Int?
    let plusMinus: String?
    let comment: String?
}

// MARK: - Game
struct Game: Codable {
    let id: Int?
}

// MARK: - Player
struct Player: Codable {
    let id: Int?
    let firstname, lastname: String?
}

//SPORTS.IO DATA
struct PlayerSportsIo: Codable {
    let playerID: Int?
    let sportsDataID, status: String?
    let teamID: Int?
    let team: String?
    let jersey: Int?
    let positionCategory, position, firstName, lastName: String?
    let height, weight: Int?
    let birthDate, birthCity, birthState, birthCountry: String?
    let highSchool, college: String?
    let salary: Int?
    let photoURL: String?
    let experience: Int?
    let sportRadarPlayerID: String?
    let rotoworldPlayerID, rotoWirePlayerID, fantasyAlarmPlayerID, statsPlayerID: Int?
    let sportsDirectPlayerID, xmlTeamPlayerID: Int?
    let injuryStatus, injuryBodyPart, injuryStartDate, injuryNotes: String?
    let fanDuelPlayerID, draftKingsPlayerID, yahooPlayerID: Int?
    let fanDuelName, draftKingsName, yahooName, depthChartPosition: String?
    let depthChartOrder, globalTeamID: Int?
    let fantasyDraftName: String?
    let fantasyDraftPlayerID, usaTodayPlayerID: Int?
    let usaTodayHeadshotURL, usaTodayHeadshotNoBackgroundURL: String?
    let usaTodayHeadshotUpdated, usaTodayHeadshotNoBackgroundUpdated: String?
    let nbaDotCOMPlayerID: Int?

    enum CodingKeys: String, CodingKey {
        case playerID = "PlayerID"
        case sportsDataID = "SportsDataID"
        case status = "Status"
        case teamID = "TeamID"
        case team = "Team"
        case jersey = "Jersey"
        case positionCategory = "PositionCategory"
        case position = "Position"
        case firstName = "FirstName"
        case lastName = "LastName"
        case height = "Height"
        case weight = "Weight"
        case birthDate = "BirthDate"
        case birthCity = "BirthCity"
        case birthState = "BirthState"
        case birthCountry = "BirthCountry"
        case highSchool = "HighSchool"
        case college = "College"
        case salary = "Salary"
        case photoURL = "PhotoUrl"
        case experience = "Experience"
        case sportRadarPlayerID = "SportRadarPlayerID"
        case rotoworldPlayerID = "RotoworldPlayerID"
        case rotoWirePlayerID = "RotoWirePlayerID"
        case fantasyAlarmPlayerID = "FantasyAlarmPlayerID"
        case statsPlayerID = "StatsPlayerID"
        case sportsDirectPlayerID = "SportsDirectPlayerID"
        case xmlTeamPlayerID = "XmlTeamPlayerID"
        case injuryStatus = "InjuryStatus"
        case injuryBodyPart = "InjuryBodyPart"
        case injuryStartDate = "InjuryStartDate"
        case injuryNotes = "InjuryNotes"
        case fanDuelPlayerID = "FanDuelPlayerID"
        case draftKingsPlayerID = "DraftKingsPlayerID"
        case yahooPlayerID = "YahooPlayerID"
        case fanDuelName = "FanDuelName"
        case draftKingsName = "DraftKingsName"
        case yahooName = "YahooName"
        case depthChartPosition = "DepthChartPosition"
        case depthChartOrder = "DepthChartOrder"
        case globalTeamID = "GlobalTeamID"
        case fantasyDraftName = "FantasyDraftName"
        case fantasyDraftPlayerID = "FantasyDraftPlayerID"
        case usaTodayPlayerID = "UsaTodayPlayerID"
        case usaTodayHeadshotURL = "UsaTodayHeadshotUrl"
        case usaTodayHeadshotNoBackgroundURL = "UsaTodayHeadshotNoBackgroundUrl"
        case usaTodayHeadshotUpdated = "UsaTodayHeadshotUpdated"
        case usaTodayHeadshotNoBackgroundUpdated = "UsaTodayHeadshotNoBackgroundUpdated"
        case nbaDotCOMPlayerID = "NbaDotComPlayerID"
    }
}

