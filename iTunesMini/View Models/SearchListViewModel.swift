//
//  SearchListViewModel.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import Foundation
import SwiftUI
import RealmSwift

class SearchListViewModel: ObservableObject {
    
    @Published var filteredTracks = [TrackViewModel]()
    @Published private(set) var resultMessage = ""
    @Published var searchText = ""
    @Published var isSearching: Bool = false
    
    fileprivate let apiManager: TracksAPIManager
    fileprivate let dbManager: TracksDBManager
    
    fileprivate let tracksResults: Results<Track>
    fileprivate var token: NotificationToken?
    fileprivate var listResult = ListResult.all {
        didSet {
            self.resultMessage = listResult.title
        }
    }
    
    fileprivate enum ListResult {
        case all
        case filtered(String)
        case errorSearch(String)
        
        var title: String {
            switch self {
            case .all:
                return "Showing Existing Tracks"
                
            case .filtered(let searchText):
                return "Showing results for '\(searchText)'"
                
            case .errorSearch(let searchText):
                return "An error occurred while searching for '\(searchText)'..."
            }
        }
        
    }

    
    init(
        apiManager: TracksAPIManager = TracksAPIManager.shared,
        dbManager: TracksDBManager = TracksDBManager.shared
    ) {
        self.apiManager = apiManager
        self.dbManager = dbManager
        
        tracksResults = dbManager.fetchAllTracks()
        token = tracksResults.observe { changes in
            switch changes {
            case .initial(let existingTracks):
                print("Existing Tracks")
                self.listResult = .all
                self.filteredTracks = TrackViewModel.parseTracks(Array(existingTracks))

            case .update(_, deletions: _, insertions: _, modifications: let mods):
                if mods.isEmpty == false {
                    self.fetchAllTracks()
                }

            default:
                break
            }
        }
    }
    
    deinit {
        token?.invalidate()
    }
    
    fileprivate func fetchAllTracks() {
        filteredTracks = TrackViewModel.parseTracks(Array(tracksResults))
    }
    
    func searchTracks() {
        print("Search! \(searchText)")
        // TODO: - On Cancel
        if searchText.isEmpty { return }
        
        isSearching = true
        apiManager.searchTracks(searchText: searchText) { result in
            self.isSearching = false
            
            switch result {
            case .success(_):
                self.listResult = .filtered(self.searchText)
                
            case .failure(let error):
                print("Error fetching api tracks: \(error)")
                self.listResult = .errorSearch(self.searchText)
                self.filteredTracks = []
            }
        }
    }
        
}
