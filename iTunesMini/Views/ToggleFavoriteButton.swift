//
//  ToggleFavoriteButton.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/17/22.
//

import SwiftUI

struct ToggleFavoriteButton: View {
    let isFavorite: Bool
    let size: CGFloat
    let toggleAction: (() -> Void)
    
    var body: some View {
        Button {
            toggleAction()
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.system(size: size))
                .foregroundColor(isFavorite ? Color.red : Color.gray)
        }
    }
}

struct ToggleFavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        ToggleFavoriteButton(isFavorite: false, size: 17) {}
    }
}
