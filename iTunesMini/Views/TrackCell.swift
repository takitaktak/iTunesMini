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
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                    
                default:
                    ZStack {
                        Image(systemName: "music.note")
                            .font(.title)
                    }.frame(maxWidth: .infinity)
                    
                }
            }
            .frame(height: 100, alignment: .center)
            .background(Color(UIColor.lightGray))
            .clipped()
            
            // Favorite Button
            .overlay(alignment: .bottomTrailing) {
                Text(track.price)
                    .font(.system(size: 13, weight: .bold))
                    .lineLimit(1)
                    .foregroundColor(Color.white)
                    .padding(7)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(15)
                    .padding(3)
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
