//
//  TrackListView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/16/22.
//

import Foundation
import SwiftUI

struct TrackListView: View {
    
    @Binding var tracks: [TrackViewModel]    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(tracks, id: \.id) { trackVM in
                    NavigationLink {
                        TrackDetailView()
                            .environmentObject(trackVM)
                    } label: {
                        TrackCell()
                            .environmentObject(trackVM)
                    }
                }
            }
        }
    }
}
