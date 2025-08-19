//
//  GameOverView.swift
//  RMITCasinoLiveCode
//
//  Created by Tom Huynh on 19/8/25.
//

import SwiftUI

struct GameOverView: View {
    // MARK: - PROPERTIES
    
    @Binding var showModal: Bool
    @Binding var coins: Int
    
    // MARK: - BODY
    
    var body: some View {
        ZStack{
            // Use the correct color name from your assets
            Color("ColorBlackTransparentRMIT")
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("GAME OVER")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                    .background(Color("ColorRedRMIT"))
                
                Spacer()
                
                VStack {
                    Image("rmit-casino-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 150)
                    
                    Text("You lost all money!\nYou are not the god of gambler!\n Good luck next time!")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    
                    Button {
                        // Action: Hide the modal and reset coins
                        self.showModal = false
                        self.coins = 100
                        playSound(sound: "ring-up", type: "mp3")
                    } label: {
                        Text("New Game".uppercased())
                            .foregroundColor(Color.white)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal, 20)
                    .background(
                        Capsule()
                            .strokeBorder(lineWidth: 2)
                            .foregroundColor(Color("ColorRedRMIT"))
                    )
                }
                
                Spacer()
            }
            .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 280, idealHeight: 300, maxHeight: 350, alignment: .center)
            .background(Color("ColorBlueRMIT"))
            .cornerRadius(20)
            .shadow(color: Color("ColorBlackTransparentRMIT"), radius: 15)
            
        }.onAppear(perform: {
            playSound(sound: "drum-music", type: "mp3")
        })
    }
}

// MARK: - PREVIEW

#Preview {
    // Use .constant for bindings in previews
    GameOverView(showModal: .constant(true), coins: .constant(100))
}
