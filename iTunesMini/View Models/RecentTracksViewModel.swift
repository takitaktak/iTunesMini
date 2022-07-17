//
//  RecentTracksViewModel.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/18/22.
//

import SwiftUI
import RealmSwift
import Combine

class RecentTracksViewModel: ObservableObject {
    
    @ObservedObject var store: TracksStore
    @Published var recentTracks = [TrackViewModel]()
    
    var subscription: AnyCancellable?
    
    // MARK: - Object Life Cycle
    init(store: TracksStore = TracksStore.shared) {
        self.store = store
        
        subscription = store.objectWillChange.sink { [weak self] _ in
            self?.recentTracks = TrackViewModel.parseTracks(Array(store.recentTracks))
        }
    }
}
