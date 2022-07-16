//
//  SearchTracksListView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import SwiftUI

struct SearchTracksListView: View {
    
    @ObservedObject var viewModel: TrackListViewModel
    
    var body: some View {
        NavigationView {
            TrackListView(tracks: $viewModel.filteredTracks)
                .searchable(text: $viewModel.searchText)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Tracks")
        }.onAppear {
            viewModel.fetchAllTracks()
        }
    }
}
