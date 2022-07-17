//
//  FavoritesListViewModel.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/16/22.
//

import Foundation
import RealmSwift

class FavoritesListViewModel: ObservableObject {
    
    // MARK: - Published properties
    @Published var favorites = [TrackViewModel]()
    
    // MARK: - Private properties
    fileprivate var token: NotificationToken?
    
    // MARK: - Object Life Cycle
    init(dbManager: TracksDBManager = TracksDBManager()) {
        let results = dbManager.favoritesResults()
        
        token = results.observe { [unowned self] changes in
            switch changes {
            case .initial(let results):
                self.parseResults(results)
                
            case .update(let updatedTracks, deletions: _, insertions: _, modifications: _):
                self.parseResults(updatedTracks)
                
            default:
                break
            }
        }
    }
    
    deinit {
        token?.invalidate()
    }
    
    // MARK: - Helper Method
    fileprivate func parseResults(_ updatedTracks: Results<Track>) {
        favorites = TrackViewModel.parseTracks(Array(updatedTracks))
    }
    
}
