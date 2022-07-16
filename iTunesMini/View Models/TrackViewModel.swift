//
//  TrackViewModel.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import Foundation

class TrackViewModel: ObservableObject {
    @Published private(set) var isFavorite = false
    
    var id: String { track.id }
    var artwork: String { track.artworkUrl60 ?? "" }
    var name: String { track.trackName ?? "n/a" }
    var genre: String { track.primaryGenreName ?? "n/a" }
    var price: Double { track.trackPrice }
    var description: String { track.longDescription ?? "n/a" }
    
    fileprivate let track: Track
    fileprivate let dbManager: TracksDBManager
    
    init(_ track: Track, dbManager: TracksDBManager = TracksDBManager()) {
        self.track = track
        self.dbManager = dbManager
        self.isFavorite = track.isFavorite
    }
    
    func toggleIsFavorite() {
        dbManager.toggleTrackFavorite(track)
        isFavorite = track.isFavorite
    }
    
}

// MARK: - Helper Methods
extension TrackViewModel {
    static func parseTracks(_ tracks: [Track] ) -> [TrackViewModel] {
        return tracks.map({ TrackViewModel($0) })        
    }
}
