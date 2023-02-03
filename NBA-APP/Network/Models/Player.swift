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
