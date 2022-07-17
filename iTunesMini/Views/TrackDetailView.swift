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
                // Artwork
                AsyncImage(url: URL(string: track.artwork)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                        
                    default:
                        ZStack {
                            Image(systemName: "music.note")
                                .font(.title)
                                .foregroundColor(Color.accentColor)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(UIColor.lightGray))
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200, alignment: .center)
                .clipped()
                
                // Favorite Button
                .overlay(alignment: .bottomTrailing) {
                    Text(track.price)
                        .font(.system(size: 15, weight: .bold))
                        .lineLimit(1)
                        .foregroundColor(Color.white)
                        .padding(7)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(15)
                        .padding(3)
                }
                
                // Track Name
                Text(track.name)
                    .font(.system(size: 15, weight: .semibold))
                    .lineLimit(1)
                    .foregroundColor(Color.accentColor)
                
                HStack {
                    Text(track.genre)
                        .font(.system(size: 13, weight: .light))
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Button {
                        track.toggleIsFavorite()
                    } label: {
                        Image(systemName: track.isFavorite ? "heart.fill" : "heart")
                            .font(.system(size: 20))
                            .foregroundColor(track.isFavorite ? Color.red : Color.gray)
                    }
                    
                }
                
                Text(track.description)
                    .font(.system(size: 13, weight: .light))
            }.padding(10)
        }
    }
}
