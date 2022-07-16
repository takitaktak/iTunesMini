//
//  RootView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var tracksStore: TracksStore
    
    var body: some View {
        TabView {
            SearchTracksListView()
                .tabItem {
                    Label("Tracks", systemImage: "music.quarternote.3")
                }
            
            FavoritesListView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }.accentColor(Color.pink)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
