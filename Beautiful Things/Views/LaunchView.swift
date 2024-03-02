//
//  ContentView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//
import SwiftUI

struct LaunchView: View {
    @Environment(AppModel.self) private var appModel
    @Binding var showMainView: Bool
    enum AnimationState {
        case initial, showFinalText, fadeOutFinalText, completed
    }
    
    @State private var animationState = AnimationState.initial
    @State private var displayedText = "" // New state variable for the animated text
    
    let fullText = "Hello Beautiful" // The full text to display
    let typingAnimationDelay = 0.15 // Delay between each character
    
    var body: some View {
        
        ZStack {
            // Background Spacer for ZStack to occupy full screen
            Spacer()
            
            // Initial text conditionally shown
            if animationState == .initial {
                Text("𖡼")
                    .font(.system(size: 200))
                    .opacity(animationState == .initial ? 1 : 0)
                    .animation(.easeInOut(duration: 2), value: animationState)
                    .transition(.opacity)
            }
            
            // Final text conditionally shown
            if animationState == .showFinalText || animationState == .fadeOutFinalText {
                Text(displayedText)
                    .font(.extraLargeTitle)
                    .opacity(animationState == .showFinalText || animationState == .fadeOutFinalText ? 1 : 0)
                    .animation(.easeInOut(duration: 2).delay(3), value: animationState) // Adjust as necessary
                    .transition(.opacity)
                    .onAppear {
                        if animationState == .showFinalText {
                            for (index, character) in fullText.enumerated() {
                                DispatchQueue.main.asyncAfter(deadline: .now() + typingAnimationDelay * Double(index)) {
                                    displayedText.append(character)
                                }
                            }
                        }
                    }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    animationState = .initial
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    animationState = .showFinalText
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    animationState = .fadeOutFinalText
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                withAnimation(.easeInOut(duration: 2.0)) { // Increase the duration here
                    animationState = .completed
                    appModel.showLaunchScreen = false
                    showMainView = true // This line triggers the transition to MainView
                }
            }
            
            appModel.fetchAllItems(url: "https://beautifulthings.xyz/category/random-access-memories")
        }
    }
}


