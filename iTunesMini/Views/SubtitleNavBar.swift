//
//  SubtitleNavBar.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/17/22.
//

import SwiftUI

struct SubtitleNavBar: View {
    let title: String
    
    var body: some View {
        VStack(spacing: 3) {
            Text(title)
                .font(.headline)
            LastVisitView()
        }
    }
}

struct SubtitleNavBar_Previews: PreviewProvider {
    static var previews: some View {
        SubtitleNavBar(title: "Title")
    }
}
