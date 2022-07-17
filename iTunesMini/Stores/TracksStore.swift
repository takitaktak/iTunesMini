//
//  TracksStore.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/18/22.
//

import Foundation
import RealmSwift

class TracksStore: ObservableObject {
    
    // MARK: - "Published" properties
    var favorites = [Track]() {
        didSet {
            objectWillChange.send()
        }
    }
    
    var recentTracks = [Track]() {
        didSet {
            objectWillChange.send()
        }
    }
    
    var searchedTracks = [Track]() {
        didSet {
            objectWillChange.send()
        }
    }
    
    // MARK: - Notification Tokens
    fileprivate var favoritesToken: NotificationToken?
    fileprivate var recentsToken: NotificationToken?
    fileprivate var searchedToken: NotificationToken?
    
    static let shared = TracksStore()
    
    fileprivate let apiManager: TracksAPIManager
    fileprivate let dbManager: TracksDBManager
    
    init(
        apiManager: TracksAPIManager = TracksAPIManager.shared,
        dbManager: TracksDBManager = TracksDBManager.shared
    ) {
        self.apiManager = apiManager
        self.dbManager = dbManager
        
        observeFavorites()
        observeRecentTracks()
    }
    
}

// MARK: - Favorites Methods
extension TracksStore {
    
    fileprivate func observeFavorites() {
        let results = dbManager.fetchFavorites()
        favoritesToken = results.observe { [unowned self] changes in
            switch changes {
            case .initial(_), .update(_, deletions: _, insertions: _, modifications: _):
                self.favorites = Array(results)
            default:
                break
            }
        }
    }
    
}

// MARK: - Recent Tracks Methods
extension TracksStore {
    
    fileprivate func observeRecentTracks() {
        let results = dbManager.fetchAllTracks()
        recentsToken = results.observe { [unowned self] changes in
            switch changes {
            case .initial(_), .update(_, deletions: _, insertions: _, modifications: _):
                self.recentTracks = Array(results)
            default:
                break
            }
        }
    }
    
}

// MARK: - Search Tracks
extension TracksStore {
    
    enum SearchResult {
        case success
        case empty
        case error
    }
    
    func searchTracks(_ searchText: String, completion: @escaping (SearchResult) -> Void) {
        if searchText.isEmpty { return }
        
        apiManager.searchTracks(searchText: searchText) { result in
            switch result {
            case .success(let tracks):
                let resultsToObserve = self.dbManager.saveTracks(tracks: tracks)
                self.observeSearches(resultsToObserve)
                completion(tracks.isEmpty ? .empty : .success)
                
            case .failure(let error):
                print("Error fetching api tracks: \(error)")
                self.searchedTracks = []
                completion(.error)
                
            }
        }
    }
    
    fileprivate func observeSearches(_ results: Results<Track>) {
        self.searchedToken?.invalidate()
        self.searchedToken = results.observe { changes in
            switch changes {
            case .initial(_), .update(_, deletions: _, insertions: _, modifications: _):
                self.searchedTracks = Array(results)
                
            default:
                break
            }
        }
    }
    
}
