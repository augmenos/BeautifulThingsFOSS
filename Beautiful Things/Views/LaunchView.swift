//
//  LaunchView.swift
//  Beautiful Things
//
//  The first view upon launching the app. 
//
import SwiftUI

struct LaunchView: View {
    @Environment(AppModel.self) private var appModel
    @Binding var showMainView: Bool
    @State private var isLoading = true
    enum AnimationState {
        case initial, showFinalText, fadeOutFinalText, completed
    }
    
    @State private var animationState = AnimationState.initial
    @State private var displayedText = "" // New state variable for the animated text.
    
    let fullText = "Hello Beautiful" // The full text to display.
    let typingAnimationDelay = 0.15 // Delay between each character.
    
    var body: some View {
        
        ZStack {
            // Background Spacer for ZStack to occupy full screen.
            // Initial text conditionally shown.
            if animationState == .initial {
                Text("𖡼")
                    .font(.system(size: 200))
                    .opacity(animationState == .initial ? 1 : 0)
                    .animation(.easeInOut(duration: 2), value: animationState)
                    .transition(.opacity)
            }
            
            // Final text conditionally shown.
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
            // Timing the animation states.
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
                withAnimation(.easeInOut(duration: 2.0)) {
                    animationState = .completed
                    appModel.showLaunchScreen = false
                    showMainView = true // This line triggers the transition to MainView.
                }
            }
            
        }
    }
}


