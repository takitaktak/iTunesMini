//
//  FavoritesListViewModel.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/16/22.
//

import Foundation

class FavoritesListViewModel: ObservableObject {
    fileprivate let store: TracksStore
    
    @Published var favorites = [TrackViewModel]()
    
    init(store: TracksStore) {
        self.store = store
    }
    
    func fetchFavorites() {
        favorites = TrackViewModel.parseTracks(store.fetchFavorites())
    }
}
