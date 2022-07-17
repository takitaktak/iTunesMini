//
//  TrackCell.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import SwiftUI

struct TrackCell: View {
    let track: TrackViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            // Artwork & Price
            buildThumbnailView()
                .overlay(alignment: .topTrailing) {
                    ToggleFavoriteButton(isFavorite: track.isFavorite, size: 13) {
                        track.toggleIsFavorite()
                    }
                    .padding(2)
                }
            
            buildNameLabel()
            buildGenreLabel()
            buildPriceLabel()
        }
        .padding(10)
    }
    
    fileprivate func buildThumbnailView() -> some View {
        AsyncImage(url: URL(string: track.artwork)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                
            default:
                PlaceholderImageView(iconSize: 20)
            }
        }
        .frame(width:100, height: 100, alignment: .center)
        .clipped()
    }
    
    fileprivate func buildPriceLabel() -> some View {
        return Text(track.price)
            .font(.system(size: 10, weight: .regular))
            .foregroundColor(Color(UIColor.darkGray))
            .lineLimit(1)
            
    }
    
    fileprivate func buildNameLabel() -> some View {
        return Text(track.name)
            .font(.system(size: 12, weight: .semibold))
            .lineLimit(1)
            
    }
    
    fileprivate func buildGenreLabel() -> some View {
        return Text(track.genre)
            .font(.system(size: 11, weight: .light))
            .foregroundColor(Color.gray)
            .lineLimit(1)
    }
}
