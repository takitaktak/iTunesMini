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
            // Artwork
            AsyncImage(url: URL(string: track.artwork)) { phase in
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
            .frame(height: 100, alignment: .center)
            .clipped()
            
            // Favorite Button
            .overlay(alignment: .bottomTrailing) {
                Text(track.price)
                    .padding(2)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(Color.white)
                    .lineLimit(1)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(7)
                    .padding(5)
            }
            
            // Track Name
            Text(track.name)
                .font(.system(size: 14, weight: .semibold))
                .lineLimit(1)
            
            HStack {
                Text(track.genre)
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(Color.gray)
                    .lineLimit(1)
                
                Spacer()
                
                Button {
                    print("Favorite tapped!")
                    track.toggleIsFavorite()
                } label: {
                    Image(systemName: track.isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 17))
                        .foregroundColor(track.isFavorite ? Color.red : Color.gray)
                }
                
            }
        }.padding(5)
    }
}
