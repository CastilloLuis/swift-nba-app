//
//  NBA_APPApp.swift
//  NBA-APP
//
//  Created by Luis Castillo on 1/30/23.
//

import SwiftUI

@main
struct NBA_APPApp: App {
    var network = Network()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(network)
        }
    }
}
