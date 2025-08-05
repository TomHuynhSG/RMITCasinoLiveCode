//
//  ContentView.swift
//  RMITCasinoLiveCode
//
//  Created by Tom Huynh on 5/8/25.
//

import SwiftUI

struct ContentView: View {
    let icons = ["apple","bar","cherry","clover","diamond", "grape", "heart", "horseshoe","lemon","melon","money","orange"]
    
    @State private var reels = [6, 3, 1]
    
    func spinReels() {
        reels[0] = Int.random(in: 0...icons.count - 1)
        reels[1] = Int.random(in: 0...icons.count - 1)
        reels[2] = Int.random(in: 0...icons.count - 1)
    }
    
    var body: some View {
        ZStack {
            // MARK: - Background
            LinearGradient(gradient: Gradient(colors: [ Color("ColorRedRMIT"),Color("ColorPurpleRMIT")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                // MARK: - Logo
                LogoView(logoFileName: "rmit-casino-welcome-logo")
                
                Spacer()
                
                // MARK: - Score boards
                HStack {
                    HStack {
                        Text("Your\nMoney".uppercased())
                            .multilineTextAlignment(.leading)
                            .modifier(scoreLabelStyle())
                        
                        Text("100")
                            .modifier(scoreNumberStyle())
                    }
                    .modifier(scoreCapsuleStyle())
                    
                    Spacer()
                    
                    HStack {
                        Text("500")
                            .modifier(scoreNumberStyle())
                        
                        Text("High\nScore".uppercased())
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(Color.colorWhiteRMIT)
                            .modifier(scoreLabelStyle())
                        
                    }
                    .modifier(scoreCapsuleStyle())
                }
        
                Spacer()
                
                // MARK: - Slot Machine
                VStack {
                    // MARK: - First Reel
                    ZStack {
                        Image("reel")
                            .resizable()
                            .modifier(reelImageStyle())
                        Image(icons[reels[0]])
                            .resizable()
                            .modifier(iconImageStyle())
                    }
                    
                    HStack {
                        // MARK: - Second Reel
                        ZStack {
                            Image("reel")
                                .resizable()
                                .modifier(reelImageStyle())
                            Image(icons[reels[1]])
                                .resizable()
                                .modifier(iconImageStyle())
                        }
                        
                        // MARK: - Third Reel
                        ZStack {
                            Image("reel")
                                .resizable()
                                .modifier(reelImageStyle())
                            Image(icons[reels[2]])
                                .resizable()
                                .modifier(iconImageStyle())
                        }
                        
                    }
                    
                    // MARK: - Spin Button
                    Button {
                        spinReels()
                    } label: {
                        ZStack {
                            Image("spin")
                                .resizable()
                                .modifier(reelImageStyle())
                        }
                    }

                    
                    
                    
                }
                
                // MARK: - Footer
                HStack {
                    HStack (spacing: 30) {
                        Text("10")
                            .modifier(betCapsuleStyle())
                        
                        Image("casino-chips")
                            .resizable()
                            .modifier(casinoChipStyle())
                            .opacity(0)
                    }
                    
                    Spacer()
                    
                    HStack (spacing: 30) {
                        Image("casino-chips")
                            .resizable()
                            .modifier(casinoChipStyle())
                        
                        
                        Text("20")
                            .modifier(betCapsuleStyle())
                    }
                }
                .padding(.horizontal, 20)
                
                
                
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

