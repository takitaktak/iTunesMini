//
//  iTunesMiniApp.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/15/22.
//

import SwiftUI

@main
struct iTunesMiniApp: App {

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(RootViewModel())
                .accentColor(Color.pink)
        }
    }
}
