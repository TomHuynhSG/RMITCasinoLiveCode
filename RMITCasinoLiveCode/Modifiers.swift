//
//  Modifiers.swift
//  RMITCasinoLiveCode
//
//  Created by Tom Huynh on 5/8/25.
//

import Foundation
import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("ColorBlackTransparentRMIT"), radius: 15)
    }
}

struct scoreLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.colorWhiteRMIT)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
}


struct scoreNumberStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.colorWhiteRMIT)
            .font(.system(size: 20, weight: .bold, design: .rounded))
    }
}

struct scoreCapsuleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(
                Capsule()
                    .foregroundColor(Color.colorBlackTransparentRMIT)
            )
    }
}

struct reelImageStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 140, idealWidth: 200, maxWidth: 220)
            .modifier(ShadowModifier())
    }
}

struct iconImageStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(minWidth: 50, idealWidth: 60, maxWidth: 70)
            .modifier(ShadowModifier())
    }
}
struct betCapsuleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.colorWhiteRMIT)
            .font(.system(size: 25, weight: .heavy, design: .rounded))
            .modifier(ShadowModifier())
            .background(
                Capsule()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [ Color("ColorYellowRMIT"),Color("ColorRedRMIT")]), startPoint: .top, endPoint: .bottom)
                    )
                    .frame(width:80, height: 50)
            )
    }
}

struct casinoChipStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(height: 70)
            .modifier(ShadowModifier())
    }
}

    
