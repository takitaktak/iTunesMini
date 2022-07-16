//
//  FetchedTracksResponse.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import Foundation

struct FetchedTracksResponse: Decodable {
    let tracks: [APITrack]
    
    private enum CodingKeys: String, CodingKey {
        case tracks = "results"
    }
}

struct APITrack: Decodable {
    let trackName: String?
    let trackPrice: Double?
    let primaryGenreName: String?
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let longDescription: String?
}
