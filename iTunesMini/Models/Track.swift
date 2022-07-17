//
//  Track.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import Foundation
import RealmSwift

class Track: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String?
    @Persisted var price: Double = 0.0
    @Persisted var artworkUrl: String?
    @Persisted var longDescription: String?
    @Persisted var genre: String?
    @Persisted var isFavorite: Bool = false
    
    var id: String { _id.stringValue }
    
    convenience init(apiTrack: APITrack) {
        self.init()
        self.name = apiTrack.trackName
        self.price = apiTrack.trackPrice ?? 0.0
        self.artworkUrl = apiTrack.artworkUrl100
        self.longDescription = apiTrack.longDescription
        self.genre = apiTrack.primaryGenreName        
    }
    
    func toggleIsFavorite() {
        if let realm = self.realm {
            try! realm.write {
                isFavorite.toggle()
            }
        }
    }
}

// MARK: - Helper Methods
extension Track {
    static func parseApiTracks(_ apiTracks: [APITrack]) -> [Track] {
        return apiTracks.map({ Track(apiTrack: $0) })
    }
}
