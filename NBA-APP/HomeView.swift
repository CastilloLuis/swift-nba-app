//
//  HomeView.swift
//  NBA-APP
//
//  Created by Luis Castillo on 1/31/23.
//

import SwiftUI
import SkeletonUI

struct HomeView: View {
    @EnvironmentObject var network: Network
    @State var liveGames: [LiveGame] = getMockGames()
    @State var latestGames: [LiveGame] =  getMockGames()
    @State var news: [News] = []
    
    @State var selectedGameId: Int?
    @State private var offset = CGSize.zero
    @State var scrollToId: Int?
    @State var viewState = CGSize.zero
    @State var navigateToSearch: Bool = false
    @State var navigateToDetailView: Bool = false
    @State var loading: Bool = false
    
    func getLiveGames() async {
        let date = Date()
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
        let response = await network.getGames(date: dateFormatter.string(from: date))
        liveGames = response
    }
    
    func getLatestGames() async {
        let response = await network.getLastWeekHistoryGames()
        latestGames = response
        dump(latestGames)
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    VStack {
                        HStack(alignment: .center) {
                            Text("Live")
                                .customFont(.largeTitle)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            Button { navigateToSearch = true } label: {
                                Image(systemName: "magnifyingglass")
                                    .customFont(.title2)
                            }
                            .foregroundColor(.black.opacity(0.7))
                            .navigationDestination(isPresented: $navigateToSearch) {
                                SearchPlayerView()
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, -20)
                        
                        ScrollViewReader { scrollProxy in
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 20) {
                                    
                                    if (loading) {
                                        ForEach([1, 2, 3] as [Int], id: \.self) { _ in
                                            Rectangle()
                                                .skeleton(with: true)
                                                .shape(type: .rectangle)
                                                .multiline(lines: 1)
                                                .animation(type: .pulse())
                                                .frame(width: 300, height: 100)
                                                .cornerRadius(25, corners: .allCorners)
                                        }
                                    }
                                    
                                    if (!loading) {
                                        ForEach(liveGames, id: \.id) { game in
                                            LiveGameCard(statsViewOpened: false, game: game)
                                                .id(game.id)
                                                .onTapGesture {
                                                    withAnimation {
                                                        selectedGameId = game.id
                                                        navigateToDetailView = true
                                                    }
                                                }
                                        }
                                        .padding(.vertical)
                                    }
                                }
                                .padding()
                            }
                            .onChange(of: self.scrollToId) { id in
                                guard id != nil else { return }
                                
                                withAnimation {
                                    scrollProxy.scrollTo(id)
                                }
                            }
                        }
                        .padding(.bottom, -20)
                        Text("Latest Games")
                            .customFont(.largeTitle)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.bottom, -20)
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 30) {
                                
                                if (loading) {
                                    ForEach([1, 2, 3] as [Int], id: \.self) { _ in
                                        Rectangle()
                                            .skeleton(with: true)
                                            .shape(type: .rectangle)
                                            .multiline(lines: 1)
                                            .animation(type: .pulse())
                                            .frame(width: 250, height: 220)
                                            .cornerRadius(25, corners: .allCorners)
                                    }
                                }
                                
                                if (!loading) {
                                    ForEach(latestGames, id: \.id) { game in
                                        RecentGameCard(game: game)
                                    }
                                    .padding(.vertical)
                                }
                                
                            }.padding()
                        }
                        
                        if (loading) {
                            Rectangle()
                                .skeleton(with: true)
                                .shape(type: .rectangle)
                                .multiline(lines: 1)
                                .animation(type: .pulse())
                                .frame(maxWidth: .infinity)
                                .frame(height: 250)
                                .cornerRadius(25, corners: .allCorners)
                                .padding()
                        }
                        
                        if (!loading) {
                            NewsSlider(news: $news)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 80)
                }
            }
            .task {
                loading = true
                let nbaNews = await network.getNews()
                news = nbaNews
                await getLiveGames()
                await getLatestGames()
                loading = false
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, 50)
        .background(.clear)
        .sheet(isPresented: $navigateToDetailView) {
            GameDetailView(gameId: $selectedGameId)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Network())
    }
}
