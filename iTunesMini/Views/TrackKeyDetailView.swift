//
//  TrackKeyDetailView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import SwiftUI

struct TrackKeyDetailView: View {
    let track: TrackViewModel
    
    var body: some View {
        Text(track.name)
            .font(.caption)
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.yellow)
        
        HStack {
            Text(track.genre)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.green)
            
            Text(String(format: "$%.2f", track.price))
                .font(.caption)
                .frame(alignment: .trailing)
        }
    }
}
