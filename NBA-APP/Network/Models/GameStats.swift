//
//  GameStats.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/2/23.
//

import Foundation

// MARK: - GameStats
struct GameStats: Codable {
    let team: Team?
    let statistics: [Statistic]?
}

// MARK: - Statistic
struct Statistic: Codable {
    let fastBreakPoints, pointsInPaint, biggestLead, secondChancePoints: Int?
    let pointsOffTurnovers, longestRun, points, fgm: Int?
    let fga: Int?
    let fgp: String?
    let ftm, fta: Int?
    let ftp: String?
    let tpm, tpa: Int?
    let tpp: String?
    let offReb, defReb, totReb, assists: Int?
    let pFouls, steals, turnovers, blocks: Int?
    let plusMinus, min: String?
}

// MARK: - Team
struct Team: Codable {
    let id: Int?
    let name, nickname, code: String?
    let logo: String?
}

