//
//  TrackListViewModel.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import Foundation
import SwiftUI
import RealmSwift

class TrackListViewModel: ObservableObject {
    
    @Published var filteredTracks = [TrackViewModel]()
    @Published var searchText: String = "" {
        didSet {
            filterTracks()
        }
    }
    
    fileprivate var token: NotificationToken?
    fileprivate let realm = try! Realm()
    
    init() {
        let results = realm.objects(Track.self)
        
        token = results.observe { _ in
            self.filterTracks()
        }
        
        filteredTracks = Array(results).map { TrackViewModel($0) }
    }
    
    deinit {
        token?.invalidate()
    }
    
    fileprivate func fetchAllTracks() -> [TrackViewModel] {
        return Array(realm.objects(Track.self)).map { TrackViewModel($0) }
    }
    
    fileprivate func queryTracks() -> [TrackViewModel] {
        return Array(realm.objects(Track.self).where{ $0.name.contains(searchText) }).map{ TrackViewModel($0) }
    }
    
    func filterTracks() {
        if searchText.isEmpty {
            filteredTracks = fetchAllTracks()
            return
        }
        
        filteredTracks = queryTracks()
    }
    
}
