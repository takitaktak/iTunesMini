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
    var artwork: String { track.artworkUrl ?? "" }
    var name: String { track.name ?? "n/a" }
    var genre: String { track.genre ?? "n/a" }
    var price: String { String(format: "$%.2f", track.price) }
    var description: String { track.longDescription ?? "n/a" }
    
    fileprivate let track: Track
    
    init(_ track: Track) {
        self.track = track
        self.isFavorite = track.isFavorite
    }
    
    func toggleIsFavorite() {
        track.toggleIsFavorite()
    }
    
}

// MARK: - Helper Methods
extension TrackViewModel {
    static func parseTracks(_ tracks: [Track] ) -> [TrackViewModel] {
        return tracks.map({ TrackViewModel($0) })        
    }
}
