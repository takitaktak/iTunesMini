//
//  TrackCell.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import SwiftUI

struct TrackCell: View {
    @EnvironmentObject var track: TrackViewModel
    
    var body: some View {
        VStack {
            TrackThumbnailView()
            TrackKeyDetailView(track: track)
        }
    }
}
