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
        VStack(alignment: .leading) {
            // Artwork & Price
            buildThumbnailView()
                .overlay(alignment: .bottomTrailing) {
                    buildPriceLabel()
                }
            
            buildNameLabel()
            
            HStack {
                buildGenreLabel()
                
                Spacer()
                
                ToggleFavoriteButton(isFavorite: track.isFavorite, size: 17) {
                    track.toggleIsFavorite()
                }
            }
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
            .font(.system(size: 13, weight: .bold))
            .lineLimit(1)
            .foregroundColor(Color.white)
            .padding(7)
            .background(Color.black.opacity(0.5))
            .cornerRadius(15)
            .padding(3)
    }
    
    fileprivate func buildNameLabel() -> some View {
        return Text(track.name)
            .font(.system(size: 14, weight: .semibold))
            .lineLimit(1)
    }
    
    fileprivate func buildGenreLabel() -> some View {
        return Text(track.genre)
            .font(.system(size: 12, weight: .light))
            .foregroundColor(Color.gray)
            .lineLimit(1)
    }
}
