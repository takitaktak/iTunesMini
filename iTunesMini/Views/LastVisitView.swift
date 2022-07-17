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
            .frame(maxWidth: .infinity)
            .foregroundColor(Color(UIColor.gray))
            .onChange(of: scenePhase) { newPhase in
                switch newPhase {
                case .background, .inactive:
                    lastVisitString = formatter.string(from: Date())
                    
                case .active:
                    if lastVisitString.isEmpty {
                        lastVisitString = formatter.string(from: Date())
                    }
                    
                default:
                    break
                }
                
            }
    }
}

struct LastVisitView_Previews: PreviewProvider {
    static var previews: some View {
        LastVisitView()
    }
}
