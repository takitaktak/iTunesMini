//
//  SearchTracksListView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import SwiftUI

struct SearchTracksListView: View {
    
    @ObservedObject var viewModel: SearchListViewModel
    @State var searchText = ""
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 15), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isSearching {
                    ProgressView()
                        .padding()
                } else {
                    buildGridView()
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onSubmit(of: .search) {
                viewModel.searchTracks(searchText)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Search")
        }
    }
    
    fileprivate func buildGridView() -> some View {
        return LazyVGrid(columns: columns, spacing: 15, pinnedViews: [.sectionHeaders]) {
            Section {
                ForEach(viewModel.filteredTracks, id: \.id) { trackVM in
                    NavigationLink {
                        TrackDetailView(track: trackVM)
                    } label: {
                        TrackCell(track: trackVM)
                    }
                }
            } header: {
                Text(viewModel.searchResultMessage)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(5)
                    .background(Color.white)
            }            
        }.padding(10)
    }
}
