//
//  TrackViewModel.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import Foundation

class TrackViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published private(set) var isFavorite = false
    
    // MARK: - Private Properties
    fileprivate let track: Track
    
    // MARK: - Computed Properties
    var id: String { track.id }
    var artwork: String { track.artworkUrl ?? "" }
    var name: String { track.name ?? "n/a" }
    var genre: String { track.genre ?? "n/a" }
    var description: String { track.longDescription ?? "n/a" }
    var price: String {
        if track.price == nil {
            return "n/a"
        }
        return String(format: "%@ %.2f", track.currency ?? "", track.price!)
    }
    
    // MARK: - Object Life Cycle
    init(_ track: Track) {
        self.track = track
        self.isFavorite = track.isFavorite
    }
    
    // MARK: - Public Methods
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
