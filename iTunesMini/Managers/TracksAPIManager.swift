//
//  iTunesAPIManager.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import Foundation

enum APIError: Error {
    case urlError
    case responseError
    case decodingError
}

class TracksAPIManager {
    
    static let shared = TracksAPIManager()
    
    func searchTracks(searchText: String, completion: @escaping (Result<[Track], APIError>) -> Void) {
        let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
        let urlString = "https://itunes.apple.com/search?term=\(encodedSearchText)&country=au&media=movie&all"
        
        guard let url = URL(string: urlString) else {
            completion(Result.failure(APIError.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(Result.failure(APIError.responseError))
                }
                return
            }
            
            guard let tracksResponse = try? JSONDecoder().decode(FetchedTracksResponse.self, from: data) else {
                DispatchQueue.main.async {
                    completion(Result.failure(APIError.decodingError))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(Result.success(tracksResponse.tracks))
            }
        }.resume()
    }
    
}
