//
//  TracksDBManager.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import Foundation
import RealmSwift

class TracksDBManager {
    
    var hasNoTracks: Bool { realm.isEmpty }
    
    fileprivate let realm: Realm
    
    init(realm: Realm? = nil) {
        if let realm = realm {
            self.realm = realm
        } else {
            self.realm = try! Realm()
        }        
    }
    
    func saveTracks(tracks: [Track]) {
        try! realm.write {
            realm.add(tracks)
        }
    }
    
    func fetchFavorites() -> Results<Track> {
        realm.objects(Track.self).where { $0.isFavorite == true }
    }
    
    func fetchAllTracks() -> Results<Track> {
        realm.objects(Track.self)
    }
    
}
