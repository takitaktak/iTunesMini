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
    
    ///
    /// Returns the Results<Track> for the final tracks saved in realm.
    /// The result is a combination of newly added tracks and existing tracks.
    ///
    func addTracks(tracks: [Track]) -> Results<Track> {
        let finalIds = tracks.map{ addTrack($0) }
        return fetchTracks(withIds: finalIds)
    }
    
    ///
    /// We check if the track already exists to avoid duplicate entries from search requests.
    ///
    /// Returns the final primary key used to represent the track in Realm.
    ///
    func addTrack(_ track: Track) -> ObjectId {
        // If track already exists, we don't write it to the database.
        if let existingTrack = realm.objects(Track.self).first(where: { $0.isSameAPITrack(as: track) }) {
            return existingTrack._id
        }
        
        try! realm.write {
            realm.add(track)
        }
        return track._id
        
    }
    
    func fetchFavorites() -> Results<Track> {
        realm.objects(Track.self).where { $0.isFavorite == true }
    }
    
    func fetchAllTracks() -> Results<Track> {
        realm.objects(Track.self)
    }
    
    fileprivate func fetchTracks(withIds ids: [ObjectId]) -> Results<Track> {
        realm.objects(Track.self).filter("_id in %@", ids)
    }
    
}
