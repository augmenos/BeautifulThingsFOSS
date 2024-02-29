//
//  LaunchView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/23/24.
//

import SwiftUI

struct LaunchView: View {
    @Environment(AppModel.self) private var appModel
    @State private var showInitialText = true
    @State private var showFinalText = false
    @State private var fadeOutFinalText = false

    var body: some View {
        VStack {
            Spacer()

            if showInitialText {
                Text("𖡼")
                    .font(.system(size: 200))
                    .transition(.opacity)
            }

            if showFinalText {
                            Text("Hello Beautiful")
                                .font(.extraLargeTitle)
                                .opacity(fadeOutFinalText ? 0 : 1)
                                .transition(.opacity)
                        }

            Spacer()
        }
        .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeInOut(duration: 2.0)) {
                            showInitialText = false
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation(.easeInOut(duration: 2.0)) {
                            showFinalText = true
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                        withAnimation(.easeInOut(duration: 2.0)) {
                            fadeOutFinalText = true
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                        withAnimation(.easeInOut(duration: 2.0)) {
                            appModel.showLaunchScreen = false
                        }
                    }

                    appModel.fetchAllItems(url: "https://beautifulthings.xyz/category/random-access-memories")
                }
    }
}
