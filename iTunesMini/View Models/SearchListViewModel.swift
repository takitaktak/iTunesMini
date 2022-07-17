//
//  SearchListViewModel.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import Foundation
import SwiftUI
import Combine

class SearchListViewModel: ObservableObject {
    @ObservedObject var store: TracksStore
    
    @Published var filteredTracks = [TrackViewModel]()
    @Published var searchResultMessage = ""
    @Published var isSearching: Bool = false
    
    var subscription: AnyCancellable?
    
    init(store: TracksStore = TracksStore.shared) {
        self.store = store
        
        subscription = store.objectWillChange.sink { [weak self] _ in
            self?.filteredTracks = TrackViewModel.parseTracks(Array(store.searchedTracks))
        }
    }
    
    func searchTracks(_ searchText: String) {
        if searchText.isEmpty { return }
        
        isSearching = true
        store.searchTracks(searchText) { result in
            self.isSearching = false
            
            switch result {
            case .success:
                self.searchResultMessage = "Showing results for '\(searchText)'"
            case .empty:
                self.searchResultMessage = "No results found for '\(searchText)'"
            case .error:
                self.searchResultMessage = "An error occurred while searching for '\(searchText)'..."
            }
            
        }
    }
        
}
