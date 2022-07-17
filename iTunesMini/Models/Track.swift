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
    @Persisted var artworkUrl: String?
    @Persisted var longDescription: String?
    @Persisted var genre: String?
    @Persisted var isFavorite: Bool = false
    
    var id: String { _id.stringValue }
    
    private enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case price = "trackPrice"
        case artworkUrl = "artworkUrl100"
        case genre = "primaryGenreName"
    }
    
    func toggleIsFavorite() {
        guard let realm = self.realm else { return }
        try! realm.write {
            isFavorite.toggle()
        }
    }
    
}
