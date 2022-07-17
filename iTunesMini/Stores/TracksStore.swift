//
//  TracksStore.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/18/22.
//

import Foundation
import RealmSwift

class TracksStore: ObservableObject {
    
    // MARK: - Published properties
    var favorites = [Track]() {
        didSet {
            self.objectWillChange.send()
        }
    }
    
    // MARK: - Private properties
    fileprivate var favoritesToken: NotificationToken?
    
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
    }
    
    deinit {
        favoritesToken?.invalidate()
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
