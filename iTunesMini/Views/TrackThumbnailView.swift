//
//  TrackThumbnailView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import SwiftUI

struct TrackThumbnailView: View {
    
    let viewModel: TrackViewModel
    let toggleFavoriteAction: () -> Void
    
    var body: some View {
        AsyncImage(url: URL(string: viewModel.artwork)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                
            default:
                Image(systemName: "music.note")
            }
        }
        .overlay(alignment: .topTrailing) {
            Button {
                print("Favorite tapped!")
                toggleFavoriteAction()
            } label: {
                Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(viewModel.isFavorite ? Color.pink : Color.gray)
            }
            .frame(width: 20, height: 20)
            .padding(5)
        }
    }
}
