//
//  LoadingView.swift
//  Beautiful Things
//
//  An additional loading view if loading large sets of data.
//

import SwiftUI

struct LoadingView: View {

    var body: some View {
        ZStack {
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
