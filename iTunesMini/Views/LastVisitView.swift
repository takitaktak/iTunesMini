//
//  LastVisitView.swift
//  iTunesMini
//
//  Created by Katreena Bacalso on 7/17/22.
//

import SwiftUI

struct LastVisitView: View {
    @AppStorage("lastVisit") var lastVisitString: String = ""
    @Environment(\.scenePhase) var scenePhase
    
    fileprivate let formatter: DateFormatter = {
        let d = DateFormatter()
        d.dateStyle = .short
        d.timeStyle = .short
        return d
    }()
    
    var body: some View {
        Text("Last Visit: \(lastVisitString)")
            .font(.caption)
            .foregroundColor(Color(UIColor.gray))
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .background {
                    lastVisitString = formatter.string(from: Date())
                }
            }
    }
}

struct LastVisitView_Previews: PreviewProvider {
    static var previews: some View {
        LastVisitView()
    }
}
