//
//  NewsSlider.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/6/23.
//

import SwiftUI

struct NewsSlider: View {
    var label: String = "News"
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @Binding var news: [News]
    @State var latestRandomNewImage: Int?
    @State private var showWebView: Bool = false
    @State private var webViewUrl: String = "https://www.google.com"
    @State private var selectedSlide = 0
    
    func generateRandomNewsImage() -> Int {
        let randomImage = Int.random(in: 1...10)
        var next: Int
        
        repeat {
            next = Int.random(in: 1...10)
        } while randomImage == next
        
        return next
    }
    
    var body: some View {
        VStack {
            Text(label)
                .customFont(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, -10)
            if (news.count > 0) {
                TabView(selection: $selectedSlide) {
                    ForEach(Array(news.enumerated()), id: \.element.newsID) { index, _new in
                        VStack {
                            Text(_new.title?.uppercased() ?? "No Title")
                                .customFont(.title)
                                .foregroundColor(.white)
                                .padding(.top, 65)
                        }
                        .tag(index + 1)
                        .navigationDestination(isPresented: $showWebView) {
                            WebView(url: webViewUrl)
                        }
                        .padding(.horizontal, 5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            Image("news-\(generateRandomNewsImage())")
                                .resizable()
                                .frame(maxWidth: .infinity)
                                .overlay {
                                    Rectangle()
                                        .fill(
                                            .linearGradient(colors: [Color(hex: "#414345").opacity(0), .black], startPoint: .top, endPoint: .bottom)
                                        )
                                        .opacity(0.9)
                                }
                        )
                        .mask(
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                        )
                        .onTapGesture {
                            webViewUrl = _new.url ?? "https://google.com"
                            showWebView = true
                        }
                        .padding(.horizontal, 2)
                    }
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .edgesIgnoringSafeArea(.vertical)
                .padding(.top, -10)
                .onReceive(timer, perform: { _ in
                    if (news.count == 1) { return }
                    withAnimation {
                        if (selectedSlide == news.count) {
                            selectedSlide = 0
                        } else {
                            selectedSlide += 1
                        }
                    }
                })
            }
        }
    }
}

struct NewsSlider_Previews: PreviewProvider {
    static var previews: some View {
        NewsSlider(news: .constant(getMockNews()))
    }
}
