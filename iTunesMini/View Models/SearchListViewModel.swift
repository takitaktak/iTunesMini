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
        
        var title: String {
            switch self {
            case .all:
                return "Showing Existing Tracks"
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
                    self.filteredTracks = TrackViewModel.parseTracks(Array(self.tracksResults))
                }

            default:
                break
            }
        }
    }
    
    deinit {
        token?.invalidate()
    }
        
}
