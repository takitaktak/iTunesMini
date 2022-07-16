//
//  SearchTracksListView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import SwiftUI

struct SearchTracksListView: View {
    
    @ObservedObject var viewModel = TrackListViewModel()
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 15), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(viewModel.filteredTracks, id: \.id) { trackVM in
                        NavigationLink {
                            TrackDetailView(track: trackVM)
                        } label: {
                            TrackCell(track: trackVM)
                        }
                    }
                }.padding(10)
            }
            .searchable(text: $viewModel.searchText)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Tracks")
        }
        .onAppear {
            viewModel.filterTracks()
        }
    }
}
