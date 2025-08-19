//
//  ReelView.swift
//  RMITCasinoLiveCode
//
//  Created by Tom Huynh on 19/8/25.
//

import SwiftUI

struct ReelView: View {
    var reelIcon: String
    var animatingIcon: Bool
    var body: some View {
        ZStack {
            Image("reel")
                .resizable()
                .modifier(reelImageStyle())
            Image(reelIcon)
                .resizable()
                .modifier(iconImageStyle())
                .opacity(animatingIcon ? 1 : 0)
                .offset(y: animatingIcon ? 0 : -50)
        }
    }
}

#Preview {
    ReelView(reelIcon: "apple", animatingIcon: true)
}
