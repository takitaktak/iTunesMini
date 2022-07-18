//
//  Track.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import Foundation
import RealmSwift

class Track: Object, Codable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String?
    @Persisted var price: Double?
    @Persisted var currency: String?
    @Persisted var artworkUrl: String?
    @Persisted var longDescription: String?
    @Persisted var genre: String?
    @Persisted var isFavorite: Bool = false
    
    var id: String { _id.stringValue }
    
    private enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case price = "trackPrice"
        case currency = "currency"
        case artworkUrl = "artworkUrl100"
        case longDescription = "longDescription"
        case genre = "primaryGenreName"
    }
    
    ///
    /// A unique key based on the fields consumed from the api.
    ///
    ///  The Problem:
    ///   - the api doesn't give us a unique key for each item.
    ///   - this then causes duplicate entries within the database.
    ///   - we create a hash value based on these fields for 'uniqueness'
    ///
    var fieldsHashValue: Int {
        return (name ?? "").hashValue
        ^ (price ?? 0.0).hashValue
        ^ (currency ?? "").hashValue
        ^ (artworkUrl ?? "").hashValue
        ^ (longDescription ?? "").hashValue
        ^ (genre ?? "").hashValue
    }
    
    ///
    /// A convenience method for comparing fieldsHashValues between Tracks
    ///
    func isSameAPITrack(as track: Track) -> Bool {
        return fieldsHashValue == track.fieldsHashValue
    }
    
    func toggleIsFavorite() {
        guard let realm = self.realm else { return }
        try! realm.write {
            isFavorite.toggle()
        }
    }
    
}
