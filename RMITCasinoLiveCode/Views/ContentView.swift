//
//  ContentView.swift
//  RMITCasinoLiveCode
//
//  Created by Tom Huynh on 5/8/25.
//

import SwiftUI

struct ContentView: View {
    let icons = ["apple","bar","cherry","clover","diamond", "grape", "heart", "horseshoe","lemon","melon","money","orange"]
    
    @State private var reels = [0,1,2]
    @State var coins = 100
    @State var betAmount = 10
    @AppStorage("highscore") var highscore = 0
    
    @State var isChooseBet10 = true
    @State var isChooseBet20 = false
    
    @State var animatingIcon = true
    
    @State private var showingInfoView = false
    @State private var showGameOverModal = false
    
    // MARK: - Spin Logic
    func spinReels(){
        reels = reels.map({ _ in
            Int.random(in: 0...icons.count-1)
        })
        playSound(sound: "spin", type: "mp3")
    }
    
    
    // MARK: - Check Winning Logic
    func checkWinning() {
        if reels[0] == reels [1] && reels[1] == reels [2] {
            // Winning logic
            playerWins()
            
            if coins > highscore {
                newHighScore()
            } else {
                playSound(sound: "winning", type: "mp3")
            }
            
        } else {
            // Losing logic
            playerLoses()
        }
    }
    
    // MARK: - Player Winning Logic
    func playerWins() {
        coins += betAmount*10
    }
    // MARK: - Highscore Logic
    func newHighScore() {
        highscore = coins
        playSound(sound: "highscore", type: "mp3")
    }
    
    // MARK: - Player Lose Logic
    func playerLoses(){
        coins -= betAmount
    }
    // MARK: - Bet 20 Logic
    func chooseBet20(){
        betAmount=20
        isChooseBet10=false
        isChooseBet20=true
        playSound(sound: "bet-chip", type: "mp3")
    }
    // MARK: - Bet 10 Logic
    func chooseBet10(){
        betAmount=10
        isChooseBet10=true
        isChooseBet20=false
        playSound(sound: "bet-chip", type: "mp3")
    }
    
    // MARK: - Gameover
    func isGameOver() {
        if coins <= 0 {
            // SHOW MODAL MESSAGE OF GAME OVER
            showGameOverModal = true
            playSound(sound: "gameover", type: "mp3")
        }
    }
    
    // MARK: - Reset Game Logic
    func resetGame(){
        highscore = 0
        coins = 100
        chooseBet10()
        playSound(sound: "ring-up", type: "mp3")
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
                    HStack{
                        Text("Your\nMoney".uppercased())
                            .modifier(scoreLabelStyle())
                            .multilineTextAlignment(.leading)
                        
                        Text("\(coins)")
                            .modifier(scoreNumberStyle())
                    }
                    .modifier(scoreCapsuleStyle())
                    
                    Spacer()
                    
                    HStack{
                        Text("\(highscore)")
                            .modifier(scoreNumberStyle())
                        
                        Text("High\nScore".uppercased())
                            .modifier(scoreLabelStyle())
                            .multilineTextAlignment(.trailing)
                    }
                    .modifier(scoreCapsuleStyle())
                }
        
                Spacer()
                
                // MARK: - Slot Machine
                VStack {
                    
                    // MARK: - First Reel
                    ReelVew(reelIcon: icons[reels[0]], animatingIcon: animatingIcon)
                    
                    HStack {
                        // MARK: - Second Reel
                        ReelVew(reelIcon: icons[reels[1]], animatingIcon: animatingIcon)
                        
                        Spacer()
                        
                        // MARK: - Third Reel
                        ReelVew(reelIcon: icons[reels[2]], animatingIcon: animatingIcon)
                    }
                    
                    // MARK: - Spin Button
                    Button(action: {
                        
                        // move up, disappear and change reels
                        withAnimation(Animation.easeOut(duration: 0.3)) {
                            animatingIcon = false
                            spinReels()
                        }
                        
                        // move down, appear
                        withAnimation(Animation.easeOut(duration: 0.7).delay(0.3)) {
                            animatingIcon = true
                        }

                        checkWinning()
                        
                        isGameOver()
                    }, label: {
                        Image("spin")
                            .resizable()
                            .modifier(reelImageStyle())
                    })

                }
                
                // MARK: - Footer
                HStack {
                    
                    // MARK: - Bet 20
                    Button(action: {
                        chooseBet20()
                    }, label: {
                        HStack(spacing: 30) {
                            Text("20")
                                .modifier(betCapsuleStyle())
                            Image("casino-chips")
                                .resizable()
                                .modifier(casinoChipStyle())
                                .opacity(isChooseBet20 ? 1: 0)
                        }
                    })
                    
                    
                    
                    Spacer()
                    
                    // MARK: - Bet 10
                    Button(action: {
                        chooseBet10()
                    }, label: {
                        HStack(spacing: 30) {
                            Image("casino-chips")
                                .resizable()
                                .modifier(casinoChipStyle())
                                .opacity(isChooseBet10 ? 1: 0)
                            Text("10")
                                .modifier(betCapsuleStyle())
                                
                        }
                    })
                    
                    
                    
                }
                .padding(.horizontal, 20)
                
                
                
            }
            .overlay(
              
              // MARK: - INFO GAME BUTTON
              Button(action: {
                  self.showingInfoView = true
              }) {
                Image(systemName: "info.circle")
                  .foregroundColor(.white)
              }
              .modifier(ButtonStyle()),
              alignment: .topTrailing
            )
              .padding()
              .frame(maxWidth: 720)
              .blur(radius:  showGameOverModal ? 5 : 0 , opaque: false)
            
            if showGameOverModal{
                ZStack{
                    Color("ColorBlackTransparent")
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
                                self.showGameOverModal = false
                                self.coins = 100
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
                }.onAppear(perform: {
                    playSound(sound: "drum-music", type: "mp3")
                  })
            }
        }
        .sheet(isPresented: $showingInfoView) {
            InfoView()
          }
    }
}

#Preview {
    ContentView()
}

