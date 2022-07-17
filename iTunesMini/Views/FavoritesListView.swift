//
//  FavoritesListView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/16/22.
//

import SwiftUI

struct FavoritesListView: View {
    
    @ObservedObject var viewModel: FavoritesListViewModel
    
    fileprivate let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 15), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(viewModel.favorites, id: \.id) { track in
                        NavigationLink {
                            TrackDetailView(track: track)
                        } label: {
                            TrackCell(track: track)
                        }
                    }
                }.padding(10)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Favorites")
        }
    }
}
