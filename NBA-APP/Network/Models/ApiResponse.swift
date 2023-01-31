//
//  ApiResponse.swift
//  NBA-APP
//
//  Created by Luis Castillo on 1/31/23.
//

import Foundation

// MARK: - Welcome
struct ApiBaseResponse: Codable {
    let get: String?
    let parameters: Parameters?
    let errors: [JSONAny]
    let results: Int
    let response: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case get = "get"
        case parameters, errors, results, response
    }
}

// MARK: - Parameters
struct Parameters: Codable {
    let date: String
}
