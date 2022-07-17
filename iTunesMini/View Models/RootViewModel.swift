//
//  RootViewModel.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/17/22.
//

import Foundation

enum InitializeResult {
    case loading
    case success
    case failure(String)
}

class RootViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var result = InitializeResult.loading
    
    // MARK: - Private Properties
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
    
    // MARK: - Private Helper Methods
    fileprivate func initializeTracks() {
        
        if dbManager.hasNoTracks {
            fetchAPITracks()
            return
        }
        
        result = .success
    }
    
    fileprivate func fetchAPITracks() {
        apiManager.fetchTracks { [unowned self] result in
            switch result {
            case .success(let tracks):
                self.dbManager.saveTracks(tracks: tracks)
                self.result = .success
                
            case .failure(let error):
                print("Error fetching api tracks: \(error)")
                self.result = .failure("An error occured while loading the tracks. Please try again later!")
            }
        }
    }
    
}
