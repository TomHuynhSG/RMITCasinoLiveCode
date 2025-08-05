//
//  LogoView.swift
//  RMITCasinoLiveCode
//
//  Created by Tom Huynh on 5/8/25.
//

import SwiftUI

struct LogoView: View {
    var logoFileName: String
    
    var body: some View {
        Image(logoFileName)
            .resizable()
            .scaledToFit()
            .frame(minWidth: 250, idealWidth: 280, maxWidth: 320)
            .modifier(ShadowModifier())
    }
}


#Preview {
    LogoView(logoFileName: "rmit-casino-welcome-logo")
}
