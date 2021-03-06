//
//  TrackDetailView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import SwiftUI

struct TrackDetailView: View {
    let track: TrackViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                buildThumbnailView()
                buildNameLabel()
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        buildGenreLabel()
                        buildPriceLabel()
                    }
                    Spacer()
                    
                    ToggleFavoriteButton(isFavorite: track.isFavorite, size: 20) {
                        track.toggleIsFavorite()
                    }
                }
                
                buildDescriptionLabel()
            }
            .padding(10)
        }
    }
    
    fileprivate func buildGenreLabel() -> some View {
        Text(track.genre)
            .font(.system(size: 13, weight: .light))
            .foregroundColor(Color.gray)
            .lineLimit(1)
    }
    
    fileprivate func buildNameLabel() -> some View {
        Text(track.name)
            .font(.system(size: 15, weight: .semibold))
            .lineLimit(1)
            .foregroundColor(Color.accentColor)
    }
    
    fileprivate func buildPriceLabel() -> some View {
        Text(track.price)
            .font(.system(size: 12, weight: .light))
            .foregroundColor(Color(UIColor.darkGray))
            .lineLimit(1)
    }
    
    fileprivate func buildThumbnailView() -> some View {
        AsyncImage(url: URL(string: track.artwork)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                
            default:
                PlaceholderImageView(iconSize: 25)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100, alignment: .center)
        .clipped()
    }
    
    fileprivate func buildDescriptionLabel() -> Text {
        Text(track.description)
            .font(.system(size: 13, weight: .light))
    }
}
