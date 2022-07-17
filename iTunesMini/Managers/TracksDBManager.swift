//
//  TracksDBManager.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import Foundation
import RealmSwift

class TracksDBManager {
    
    static let shared = TracksDBManager()
    
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
        tracks.forEach{ saveTrack($0) }
    }
    
    func saveTrack(_ track: Track) {
        // If track already exists, we don't write it to the database.
        if let _ = realm.objects(Track.self).firstIndex(where: { $0.isSameAPITrack(as: track) }) {
            return
        }
        
        try! realm.write {
            realm.add(track)
        }
    }
    
    func fetchFavorites() -> Results<Track> {
        realm.objects(Track.self).where { $0.isFavorite == true }
    }
    
    func fetchAllTracks() -> Results<Track> {
        realm.objects(Track.self)
    }
    
}
