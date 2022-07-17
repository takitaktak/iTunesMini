//
//  TrackListViewModel.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import Foundation
import SwiftUI
import RealmSwift

class TrackListViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var filteredTracks = [TrackViewModel]()
    @Published var searchText: String = "" {
        didSet {
            filterTracks()
        }
    }
    
    fileprivate var token: NotificationToken?
    fileprivate let tracksResults: Results<Track>
    
    // MARK: - Object Life Cycle
    init(dbManager: TracksDBManager = TracksDBManager.shared) {
        tracksResults = dbManager.fetchAllTracks()
        token = tracksResults.observe { changes in
            switch changes {
            case .initial(_):
                self.filterTracks()
                
            case .update(_, deletions: _, insertions: _, modifications: _):
                self.filterTracks()
                
            default:
                break
            }
        }
    }
    
    deinit {
        token?.invalidate()
    }
    
    // MARK: - Private Helper Methods
    fileprivate func fetchAllTracks() {
        filteredTracks = TrackViewModel.parseTracks(Array(tracksResults))
    }

    fileprivate func queryTracks() {
        filteredTracks = TrackViewModel.parseTracks(Array(tracksResults.where{ $0.name.contains(searchText, options: .caseInsensitive) }))
    }
    
    fileprivate func filterTracks() {
        if searchText.isEmpty {
            fetchAllTracks()
            return
        }
        
        queryTracks()
    }
    
}
