//
//  ScoresActivity.swift
//  NBA-APP
//
//  Created by Luis Castillo on 3/6/23.
//

import Foundation
import ActivityKit

struct ScoresAttributes: ActivityAttributes {
    public typealias ScoresTrackingStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var homeScore: Int
        var visitorScore: Int
        var time: String
    }
    
    var game: LiveGame
    
}
