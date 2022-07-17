//
//  RootView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var viewModel: RootViewModel
    
    var body: some View {
        switch viewModel.result {
        case .failure(let message):
            buildErrorText(message)
            
        case .loading:
            ProgressView()
            
        case .success:
            tabView()
        }
    }
    
    fileprivate func buildErrorText(_ message: String) -> some View {
        return Text(message)
            .multilineTextAlignment(.center)
            .padding(10)
    }
    
    fileprivate func tabView() -> some View {
        TabView {
            SearchTracksListView()
                .tabItem {
                    Label("Tracks", systemImage: "music.quarternote.3")
                }
            
            FavoritesListView()
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
