//
//  LoadingView.swift
//  Beautiful Things
//
//  Created by Matthew Hoerl on 3/6/24.
//

import SwiftUI

struct LoadingView: View {

    var body: some View {
        ZStack {
           // Color(.systemBackground)
           //     .edgesIgnoringSafeArea(.all)
           //     .glassBackgroundEffect()

            VStack(spacing: 40) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
                
                Text("Loading 1000 Things in Your Headset")
                    .font(.title)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
