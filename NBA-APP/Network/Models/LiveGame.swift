//
//  LiveGame.swift
//  NBA-APP
//
//  Created by Luis Castillo on 1/31/23.
//

import Foundation

// MARK: - Welcome
struct LiveGame: Codable {
    let id: Int?
    let league: String?
    let season: Int?
    let date: DateClass?
    let stage: Int?
    let status: Status?
    let periods: Periods?
    let arena: Arena?
    let teams: Teams?
    let scores: Scores?
    let officials: [JSONAny]?
    let timesTied, leadChanges, nugget: JSONNull?
}

// MARK: - Arena
struct Arena: Codable {
    let name, city, state, country: JSONNull?
}

// MARK: - DateClass
struct DateClass: Codable {
    let start: String
    let end, duration: JSONNull?
}

// MARK: - Periods
struct Periods: Codable {
    let current, total: Int
    let endOfPeriod: Bool
}

// MARK: - Scores
struct Scores: Codable {
    let visitors, home: ScoresHome
}

// MARK: - ScoresHome
struct ScoresHome: Codable {
    let win, loss: Int
    let series: Series
    let linescore: [String]
    let points: Int
}

// MARK: - Series
struct Series: Codable {
    let win, loss: Int
}

// MARK: - Status
struct Status: Codable {
    let clock: JSONNull?
    let halftime: Bool
    let short: Int
    let long: String
}

// MARK: - Teams
struct Teams: Codable {
    let visitors, home: TeamsHome
}

// MARK: - TeamsHome
struct TeamsHome: Codable {
    let id: Int
    let name, nickname, code: String
    let logo: String
}
