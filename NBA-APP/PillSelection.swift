//
//  PillSelection.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/4/23.
//

import SwiftUI

struct PillSelectionTabs: Equatable {
    let id = UUID()
    let label: String
}

struct PillSelection: View {
    var tabs: [PillSelectionTabs]
    var setSelectedTeamTab: (_ tab: PillSelectionTabs) -> Void
    @State var whitePillOffset: CGFloat = -60
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    .white
                )
                .frame(width: 122, height: 34)
                .offset(x: whitePillOffset)
            HStack {
                ForEach(Array(tabs.enumerated()), id: \.element.id) { index, tab in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            setSelectedTeamTab(tab)
                            whitePillOffset = index == 0 ? -60 : 60
                        }
                    } label: {
                        VStack {
                            Text(tab.label)
                                .customFont(.footnote2)
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
                    }
                }
            }
        }
        .padding(.horizontal, 5)
        .frame(width: 250, height: 40)
        .background(
            .linearGradient(colors: [Color(hex: "#F7971E"), Color(hex: "#FFD200")], startPoint: .topTrailing, endPoint: .bottomTrailing)
        )
        .cornerRadius(20, corners: .allCorners)
    }
}

struct PillSelection_Previews: PreviewProvider {
    static var previews: some View {
        PillSelection(
            tabs: [
                PillSelectionTabs(label: "Heat"),
                PillSelectionTabs(label: "Nets")
            ]) { tab in
                print(tab)
            }
    }
}
