//
//  DynamicScores.swift
//  NBA-APP
//
//  Created by Luis Castillo on 3/6/23.
//

import ActivityKit
import WidgetKit
import SwiftUI
import Intents

struct DynamicScoresWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ScoresAttributes.self) { context in
            LockScreenLiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    GameStats(context.attributes.game.teams?.home.code, context.state.homeScore, true)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    GameStats(context.attributes.game.teams?.visitors.code, context.state.visitorScore, false)
                }
                DynamicIslandExpandedRegion(.center) {
                    VStack {
                        HStack {
                            Circle().fill(.red)
                            .frame(width: 8, height: 8)
                            .overlay {
                                Circle().fill(.red.opacity(0.5))
                                    .frame(width: 15, height: 15)
                            }
                            Text("LIVE").customFont(.footnote2).foregroundColor(.white)
                        }
                        Text(context.state.time).customFont(.footnote2).foregroundColor(.white)
                    }
                }
            } compactLeading: {
                HStack {
                    if let myImage = UIImage(named: "GameWidget/Compact/\(context.attributes.game.teams?.home.code ?? "LAL")") {
                        Image(uiImage: myImage)
                            .resizable()
                            .scaledToFit()
                    }
                    Text("145").customFont(.footnote).bold()
                }
            } compactTrailing: {
                HStack {
                    Text("90").customFont(.footnote).bold()
                    if let myImage = UIImage(named: "GameWidget/Compact/\(context.attributes.game.teams?.visitors.code ?? "LAL")") {
                        Image(uiImage: myImage)
                            .resizable()
                            .scaledToFit()
                    }
                }
            } minimal: {
                Image(systemName: "basketball")
            }
        }
    }
    
    func GameStats(_ teamCode: String?, _ score: Int, _ home: Bool) -> some View {
        HStack {
            if (home) {
                if let myImage = UIImage(named: "GameWidget/Expanded/\(teamCode ?? "LAL")") {
                    Image(uiImage: myImage)
                }
            }
            VStack {
                Text(teamCode ?? "-")
                    .customFont(.footnote)
                    .foregroundColor(.white)
                Text("\(score)").font(
                    .custom("Poppins Bold", size: 30)
                ).bold()
                .foregroundColor(.white)
            }
            if (!home) {
                if let myImage = UIImage(named: "GameWidget/Expanded/\(teamCode ?? "LAL")") {
                    Image(uiImage: myImage)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    
}


struct LockScreenLiveActivityView: View {
    let context: ActivityViewContext<ScoresAttributes>
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    if let myImage = UIImage(named: "GameWidget/Expanded/\(context.attributes.game.teams?.home.code ?? "LAL")") {
                        Image(uiImage: myImage)
                    }
                    VStack {
                        Text(context.attributes.game.teams?.home.code ?? "-")
                            .customFont(.footnote)
                            .foregroundColor(.white)
                        Text("\(context.state.homeScore)").font(
                            .custom("Poppins Bold", size: 30)
                        ).bold()
                        .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity)
                HStack {
                    VStack {
                        Text(context.attributes.game.teams?.visitors.code ?? "-")
                            .customFont(.footnote)
                            .foregroundColor(.white)
                        Text("\(context.state.homeScore)").font(
                            .custom("Poppins Bold", size: 30)
                        ).bold()
                        .foregroundColor(.white)
                    }
                    if let myImage = UIImage(named: "GameWidget/Expanded/\(context.attributes.game.teams?.visitors.code ?? "LAL")") {
                        Image(uiImage: myImage)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            HStack {
                Circle().fill(.red)
                .frame(width: 8, height: 8)
                .overlay {
                    Circle().fill(.red.opacity(0.5))
                        .frame(width: 15, height: 15)
                }
                Text("LIVE").customFont(.footnote2).foregroundColor(.white)
                Text(context.state.time).customFont(.footnote2).foregroundColor(.white)
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
}
