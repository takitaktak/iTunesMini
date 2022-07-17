//
//  RecentTracksView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/18/22.
//

import SwiftUI

struct RecentTracksView: View {
    
    @ObservedObject var viewModel: RecentTracksViewModel
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 15), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(viewModel.recentTracks, id: \.id) { trackVM in
                        NavigationLink {
                            TrackDetailView(track: trackVM)
                        } label: {
                            TrackCell(track: trackVM)
                        }
                    }                    
                }.padding(10)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    SubtitleNavBar(title: "Recents")
                }
            }
        }
    }
}
