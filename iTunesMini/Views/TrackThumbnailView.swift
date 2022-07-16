//
//  TrackThumbnailView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import SwiftUI

struct TrackThumbnailView: View {
    
    @EnvironmentObject var viewModel: TrackViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: URL(string: viewModel.artwork)) { image in
                image
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
            } placeholder: {
                Color.green
            }
            
            Button {
                viewModel.toggleIsFavorite()
            } label: {
                Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(5)
            }
        }
    }
}
