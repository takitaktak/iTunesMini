//
//  TrackDetailView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import SwiftUI

struct TrackDetailView: View {
    @EnvironmentObject var track: TrackViewModel
    
    var body: some View {
            ScrollView {
                VStack(spacing: 10) {
                    TrackThumbnailView()
                    TrackKeyDetailView(track: track)
                    Text(track.description)
                }.padding()
            }
            .navigationBarTitleDisplayMode(.inline)
    }
}
