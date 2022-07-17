//
//  FetchedTracksResponse.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import Foundation

struct FetchedTracksResponse: Decodable {
    let tracks: [Track]
    
    private enum CodingKeys: String, CodingKey {
        case tracks = "results"
    }
}
