//
//  FavoritesListView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/16/22.
//

import SwiftUI

struct FavoritesListView: View {
    
    @ObservedObject var viewModel: FavoritesListViewModel
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 15), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(viewModel.favorites, id: \.id) { trackVM in
                        VStack(alignment: .leading) {
                            // Artwork
                            AsyncImage(url: URL(string: trackVM.artwork)) { phase in
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
                            .overlay(alignment: .topTrailing) {
                                Button {
                                    print("Favorite tapped!")
                                    viewModel.toggleFavorite(for: trackVM)
                                } label: {
                                    Image(systemName: trackVM.isFavorite ? "heart.fill" : "heart")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(trackVM.isFavorite ? Color.red : Color.gray)
                                }
                                .frame(width: 20, height: 20)
                                .padding(5)
                            }
                            
                            // Track Name
                            Text(trackVM.name)
                                .font(.system(size: 14, weight: .semibold))
                                .lineLimit(1)
                            
                            HStack {
                                Text(trackVM.genre)
                                    .font(.system(size: 12, weight: .light))
                                    .foregroundColor(Color.gray)
                                    .lineLimit(1)
                                
                                Spacer()
                                
                                Text(trackVM.price)
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(Color.gray)
                                    .lineLimit(1)
                            }
                        }.padding(5)
                    }
                }.padding(10)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Favorites")
        }.onAppear {
            viewModel.fetchFavorites()
        }
    }
}
