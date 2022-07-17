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
            RecentTracksView(viewModel: RecentTracksViewModel())
                .tabItem {
                    Label("Recents", systemImage: "clock")
                }
            
            SearchTracksListView(viewModel: SearchListViewModel())
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
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
