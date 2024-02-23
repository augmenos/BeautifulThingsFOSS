//
//  LaunchView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/23/24.
//

import SwiftUI

struct LaunchView: View {
    @Environment(AppModel.self) private var appModel
    
    var body: some View {
        @Bindable var appModel = appModel
        
        VStack {
            Spacer()
            
            Text("𖡼")
                .font(.system(size: 200))
//                .padding(.bottom, 10)
            
            TitleText(title: appModel.finalTitle)
//                .padding(.horizontal, 70)
                .hidden()
                .overlay(alignment: .leading) {
                    TitleText(title: appModel.titleText)
//                        .padding(.leading, 70)
                }
            
            Spacer()
//
//            Text("Hello Beautiful")
//                .font(.extraLargeTitle)
//                .fontWeight(.light)
        }
        .typeText(
            text: $appModel.titleText,
            finalText: appModel.finalTitle,
            isFinished: $appModel.isTitleFinished,
            isAnimated: !appModel.isTitleFinished)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                withAnimation(.easeInOut(duration: 2.0)) {
                    appModel.showLaunchScreen = false
                }
            }
        }
        .onAppear {
            appModel.fetchAllItems(url: "https://beautifulthings.xyz/category/random-access-memories") 
        }
    }
}

/// The text that displays the app's title.
private struct TitleText: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.extraLargeTitle)
    }
}
