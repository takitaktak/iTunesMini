//
//  FavoritesListView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/16/22.
//

import SwiftUI

struct FavoritesListView: View {
    
    @ObservedObject var viewModel: FavoritesListViewModel
    
    var body: some View {
        NavigationView {
            TrackListView(tracks: $viewModel.favorites)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Favorites")
        }.onAppear {
            viewModel.fetchFavorites()
        }
    }
}
