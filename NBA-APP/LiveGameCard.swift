//
//  LiveGameCard.swift
//  NBA-APP
//
//  Created by Luis Castillo on 1/31/23.
//

import SwiftUI

struct LiveGameCard: View {
    var game: Any
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/fr/thumb/f/f3/Hornets_de_Charlotte_logo.svg/1200px-Hornets_de_Charlotte_logo.svg.png")) { image in
                        image.resizable()
                            .frame(maxWidth: 40, maxHeight: 40)
                    } placeholder: {
                        //put your placeholder here
                    }
                    Text("100").font(
                        .custom("Poppins Bold", size: 40)
                    )
                }
                Divider()
                HStack {
                    AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/fr/thumb/f/f3/Hornets_de_Charlotte_logo.svg/1200px-Hornets_de_Charlotte_logo.svg.png")) { image in
                        image.resizable()
                            .frame(maxWidth: 40, maxHeight: 40)
                    } placeholder: {
                        //put your placeholder here
                    }
                    Text("100").font(
                        .custom("Poppins Bold", size: 40)
                    )
                }
            }
            HStack {
                Text("LIVE").customFont(.footnote2)
                Text("1/4").customFont(.footnote2)
            }
        }
        .padding(20)
        .frame(width: 300, height: 100)
        .background(
            .linearGradient(colors: [.red, .yellow], startPoint: .top, endPoint: .bottom)
        )
        .mask(
            RoundedRectangle(cornerRadius: 25, style: .continuous)
        )
    }
}

struct LiveGameCard_Previews: PreviewProvider {
    static var previews: some View {
        let testGame = {}
        LiveGameCard(game: testGame)
    }
}
