//
//  FavoritesListViewModel.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/16/22.
//

import Foundation
import RealmSwift

class FavoritesListViewModel: ObservableObject {
    
    @Published var favorites = [TrackViewModel]()
    
    fileprivate var token: NotificationToken?
    fileprivate let realm = try! Realm()
    
    init() {
        let results = realm.objects(Track.self).where({ $0.isFavorite == true })
        favorites = Array(results).map({ TrackViewModel($0) })
        
        token = results.observe { _ in
            self.fetchFavorites()
        }
    }
    
    func fetchFavorites() {
        favorites = Array(realm.objects(Track.self).where({ $0.isFavorite == true })).map({ TrackViewModel($0) })
    }
}
