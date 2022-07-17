//
//  RootView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import SwiftUI

struct RootView: View {
    
    var body: some View {
        TabView {
            SearchTracksListView(viewModel: SearchListViewModel())
                .tabItem {
                    Label("Tracks", systemImage: "music.quarternote.3")
                }
            
            FavoritesListView(viewModel: FavoritesListViewModel())
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
