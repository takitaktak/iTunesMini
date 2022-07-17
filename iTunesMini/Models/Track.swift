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
    
    var fieldsHashValue: Int {
        return (name ?? "").hashValue
        ^ (price ?? 0.0).hashValue
        ^ (currency ?? "").hashValue
        ^ (artworkUrl ?? "").hashValue
        ^ (longDescription ?? "").hashValue
        ^ (genre ?? "").hashValue
    }
    
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
