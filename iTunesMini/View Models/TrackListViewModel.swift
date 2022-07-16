//
//  TrackListViewModel.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import Foundation
import SwiftUI

class TrackListViewModel: ObservableObject {
    
    @Published var filteredTracks = [TrackViewModel]()
    @Published var searchText: String = "" {
        didSet {
            filterTracks()
        }
    }
    
    fileprivate var tracks = [TrackViewModel]()
    fileprivate let store: TracksStore
    
    // MARK: - Life Cycle
    init(store: TracksStore = TracksStore()) {
        self.store = store
    }
    
    func fetchAllTracks() {
        tracks = store.tracks.map({ TrackViewModel($0) })
        filterTracks()
    }
    
    func filterTracks() {
        if searchText.isEmpty {
            filteredTracks = tracks
            return
        }
        
        filteredTracks = tracks.filter({ $0.name.contains(searchText) })
    }
    
}
