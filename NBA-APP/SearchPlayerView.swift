//
//  SearchPlayerView.swift
//  NBA-APP
//
//  Created by Luis Castillo on 2/6/23.
//

import SwiftUI

class TestsViewModel: ObservableObject {
    @Published var searchKey = ""
    @Published var executionTimes = 0
}

struct SearchPlayerView: View {
    @StateObject var viewModel = TestsViewModel()
    
    var body: some View {
        VStack {
            TextField(
              "Enter First Name..",
              text: $viewModel.searchKey
            )
            .textFieldStyle(.roundedBorder)
            .onReceive(
                viewModel.$searchKey.debounce(for: 1, scheduler: RunLoop.main)
             ) { seachTerm in
                viewModel.executionTimes += 1
            }

            
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Lebron James")
                                .customFont(.title4)
                            Text("PJ - JK")
                                .customFont(.footnote)
                                .foregroundColor(.black.opacity(0.7))
                        }
                        Spacer()
                        Image(systemName: "arrow.forward")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
            }
        }
        .padding(20)
    }
}

struct SearchPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlayerView()
    }
}
