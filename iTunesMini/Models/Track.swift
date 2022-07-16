//
//  Track.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import Foundation
import RealmSwift

class Track: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var trackName: String?
    @Persisted var trackPrice: Double = 0.0
    @Persisted var artworkUrl30: String?
    @Persisted var artworkUrl60: String?
    @Persisted var artworkUrl100: String?
    @Persisted var longDescription: String?
    @Persisted var primaryGenreName: String?
    @Persisted var isFavorite: Bool = false
    
    convenience init(apiTrack: APITrack) {
        self.init()
        self.trackName = apiTrack.trackName
        self.trackPrice = apiTrack.trackPrice ?? 0.0
        self.artworkUrl30 = apiTrack.artworkUrl30
        self.artworkUrl60 = apiTrack.artworkUrl60
        self.artworkUrl100 = apiTrack.artworkUrl100
        self.longDescription = apiTrack.longDescription
        self.primaryGenreName = apiTrack.primaryGenreName        
    }
    
    func toggleIsFavorite() {
        isFavorite.toggle()
    }
}

// MARK: - Helper Methods
extension Track {
    static func parseApiTracks(_ apiTracks: [APITrack]) -> [Track] {
        return apiTracks.map({ Track(apiTrack: $0) })
    }
}
