//
//  AboutView.swift
//  Beautiful Things
//
//  A simple about view with external links that opens Safari.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        @Environment(\.openURL) var openURL
        
        VStack {
            HStack {
                Text("𖡼")
                    .font(.system(size: 60))
                Text("Beautiful Things")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            
            Text("Beautiful Things is designed to fill your world with Beauty.\n")
                .fontWeight(.semibold)
            
            HStack(spacing: 0) {
                Text("Made with Love by ")
                    .fontWeight(.regular)
                
                Link("Matthew Hoerl", destination: URL(string: "https://twitter.com/MattHoerl")!)
                    .foregroundColor(.white)
            }
            
            HStack(spacing: 0) {
                Text("App developed by ")
                    .fontWeight(.regular)
                
                Link("Augmenos", destination: URL(string: "https://www.augmenos.com")!)
                    .foregroundColor(.white)
            }

            Button {
                print("Button: Feedback")
                openURL(URL(string: "https://beautifulthings.xyz/feedback")!)
            } label: {
                Image(systemName: "heart.rectangle")
                    .padding(.trailing, 3)
                Text("Send us feedback")
            }
            .padding(.vertical, 25)
            
            Text("This app is independently developed using artistic representations\nfor educational and entertainment purposes only.\nWe hope this app brings you joy.")
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
        }
        .padding(40)
    }
    
}
