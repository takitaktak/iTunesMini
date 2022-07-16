//
//  TracksDBManager.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import Foundation
import RealmSwift

class TracksDBManager {
        
    let realm = try! Realm()
    
    init() {
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    var hasNoTracks: Bool { realm.isEmpty }
    
    func saveTracks(tracks: [Track]) {
        try! realm.write {
            realm.add(tracks)
        }
    }
    
    func getTracks() -> [Track] {
        return Array(realm.objects(Track.self))
    }
    
    func getFavorites() -> [Track] {
        return Array(realm.objects(Track.self).filter({ $0.isFavorite }))
    }
    
    func toggleTrackFavorite(_ track: Track) {
        try! realm.write {
            track.toggleIsFavorite()
        }
    }
    
}
