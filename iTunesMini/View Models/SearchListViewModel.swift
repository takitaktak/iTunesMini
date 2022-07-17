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
    @Published var searchResultMessage = ""
    @Published var isSearching: Bool = false
    
    fileprivate let apiManager: TracksAPIManager
    fileprivate let dbManager: TracksDBManager
    
    fileprivate enum ListResult {
        case filtered(String)
        case errorSearch(String)
        case empty(String)
        
        var message: String {
            switch self {
            case .empty(let searchText):
                return "No results found for '\(searchText)'"
                
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
    }
    
    func searchTracks(_ searchText: String) {
        if searchText.isEmpty { return }
        
        isSearching = true
        apiManager.searchTracks(searchText: searchText) { result in
            self.isSearching = false
            
            switch result {
            case .success(let tracks):
                self.dbManager.saveTracks(tracks: tracks)
                self.filteredTracks = TrackViewModel.parseTracks(Array(tracks))
                self.searchResultMessage = tracks.isEmpty ? ListResult.empty(searchText).message : ListResult.filtered(searchText).message
                
            case .failure(let error):
                print("Error fetching api tracks: \(error)")
                self.filteredTracks = []
                self.searchResultMessage = ListResult.errorSearch(searchText).message
                
            }
        }
    }
        
}