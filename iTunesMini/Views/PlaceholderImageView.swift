//
//  PlaceholderImageView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/17/22.
//

import SwiftUI

struct PlaceholderImageView: View {
    let iconSize: CGFloat
    
    var body: some View {
        ZStack {
            Image(systemName: "music.note")
                .font(.system(size: iconSize))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.lightGray))
    }
}

struct PlaceholderImageView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderImageView(iconSize: 50)
            .frame(width: 100, height: 100, alignment: .center)
            .previewLayout(.sizeThatFits)
    }
}
