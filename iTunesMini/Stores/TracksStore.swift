//
//  TracksStore.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/16/22.
//

import Foundation

class TracksStore: ObservableObject {
    
    fileprivate(set) var tracks = [Track]()
    fileprivate let apiManager: TracksAPIManager
    fileprivate let dbManager: TracksDBManager
        
    // MARK: - Life Cycle
    init(
        apiManager: TracksAPIManager = TracksAPIManager(),
        dbManager: TracksDBManager = TracksDBManager()
    ) {
        self.apiManager = apiManager
        self.dbManager = dbManager
        initializeTracks()
    }
    
    
    // MARK: - Public Methods
    func fetchFavorites() -> [Track] {
        return tracks.filter({ $0.isFavorite })
    }
    
    // MARK: - Private Helper Methods
    fileprivate func initializeTracks() {
        if dbManager.hasNoTracks {
            fetchAPITracks()
            return
        }
        
        tracks = dbManager.getTracks()
    }
    
    fileprivate func fetchAPITracks() {
        apiManager.fetchTracks { result in
            switch result {
            case .success(let apiTracks):
                self.tracks = Track.parseApiTracks(apiTracks)
                self.saveTracks()
                
            case .failure(let error):
                print("Error fetching api tracks: \(error)")
            }
        }
    }
    
    fileprivate func saveTracks() {
        dbManager.saveTracks(tracks: tracks)
    }
}
