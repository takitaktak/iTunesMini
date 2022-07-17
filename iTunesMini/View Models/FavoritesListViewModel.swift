//
//  FavoritesListViewModel.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/16/22.
//

import Foundation
import RealmSwift
import SwiftUI
import Combine

class FavoritesListViewModel: ObservableObject {
    
    @ObservedObject var store: TracksStore
    @Published var favorites = [TrackViewModel]()
    
    var subscription: AnyCancellable?
    
    // MARK: - Object Life Cycle
    init(store: TracksStore = TracksStore.shared) {
        self.store = store
        
        subscription = store.objectWillChange.sink { [weak self] _ in
            self?.favorites = TrackViewModel.parseTracks(Array(store.favorites))
        }
    }
    
}
