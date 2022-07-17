//
//  RecentTracksViewModel.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/18/22.
//

import SwiftUI
import RealmSwift

class RecentTracksViewModel: ObservableObject {
    
    @Published var recentTracks = [TrackViewModel]()
    
    // MARK: - Private properties
    fileprivate var token: NotificationToken?
    
    // MARK: - Object Life Cycle
    init(dbManager: TracksDBManager = TracksDBManager.shared) {
        let results = dbManager.fetchAllTracks()
        
        token = results.observe { [unowned self] changes in
            switch changes {
            case .initial(let results):
                self.parseResults(results)
                
            case .update(_, deletions: _, insertions: _, modifications: _):
                self.parseResults(results)
                
            default:
                break
            }
        }
    }
    
    // MARK: - Helper Method
    fileprivate func parseResults(_ updatedTracks: Results<Track>) {
        recentTracks = TrackViewModel.parseTracks(Array(updatedTracks))
    }
    
}
