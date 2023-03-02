//
//  MainView.swift
//  NBA-APP
//
//  Created by Luis Castillo on 3/1/23.
//

import SwiftUI

enum Tabs {
    case home, teams
}

struct MainView: View {
    @State var selectedView: Tabs = Tabs.home
    
    func getTabIconSize(_ typeToCompare: Tabs) -> CGFloat {
        if (typeToCompare == selectedView) {
            return 25
        }
        return 20
    }
    
    var body: some View {
        ZStack {
            Group {
                switch selectedView {
                    case .home:
                        HomeView()
                    case .teams:
                        TeamsListView()
                }
            }
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height:10)
            }
            
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    HStack {
                        VStack {
                            Image(systemName: selectedView == Tabs.home ?  "house.fill" : "house")
                                .resizable()
                                .frame(width: getTabIconSize(Tabs.home), height: getTabIconSize(Tabs.home))
                                
                        }
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            withAnimation {
                                selectedView = Tabs.home
                            }
                        }
                        VStack {
                            Image(systemName: selectedView == Tabs.teams ? "basketball.fill" : "basketball")
                                .resizable()
                                .frame(width: getTabIconSize(Tabs.teams), height: getTabIconSize(Tabs.teams))
                        }
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            withAnimation {
                                selectedView = Tabs.teams
                            }
                        }
                    }
                    .frame(width: 200, height: 50)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 0)
                }
                .offset(x: geometry.size.width/4, y: geometry.size.height)
                .ignoresSafeArea()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Network())
    }
}
