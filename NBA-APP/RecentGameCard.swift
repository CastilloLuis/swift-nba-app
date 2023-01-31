//
//  RecentGameCard.swift
//  NBA-APP
//
//  Created by Luis Castillo on 1/31/23.
//

import SwiftUI

struct RecentGameCard: View {
    var body: some View {
            VStack(alignment: .leading) {
                Spacer()
                HStack(spacing: 10) {
                    AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/fr/thumb/f/f3/Hornets_de_Charlotte_logo.svg/1200px-Hornets_de_Charlotte_logo.svg.png")) { image in
                        image.resizable()
                            .frame(maxWidth: 100, maxHeight: 100)
                    } placeholder: {
                        //put your placeholder here
                    }
                    Text("vs").customFont(.footnote)
                    AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/fr/thumb/f/f3/Hornets_de_Charlotte_logo.svg/1200px-Hornets_de_Charlotte_logo.svg.png")) { image in
                        image.resizable()
                            .frame(maxWidth: 100, maxHeight: 100)
                    } placeholder: {
                        //put your placeholder here
                    }
                }
                Spacer()
                HStack {
                    Text("Hornets").customFont(.title2)
                    Spacer()
                    Text("100").customFont(.title)
                }
                .frame(maxWidth: .infinity)
                HStack {
                    Text("Pistons").customFont(.title2)
                    Spacer()
                    Text("99").customFont(.title)
                }
                .frame(maxWidth: .infinity)
                Spacer()
                Text("2022-02-12").customFont(.footnote2)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(20)
            .frame(width: 250, height: 280)
            .background(
                .linearGradient(colors: [.red, .yellow], startPoint: .top, endPoint: .bottom)
            )
            .mask(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
            )
    }
}

struct RecentGameCard_Previews: PreviewProvider {
    static var previews: some View {
        RecentGameCard()
    }
}
