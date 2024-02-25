//
//  ContentView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @Environment(AppModel.self) private var appModel
    
    @State private var selectedCategory: String = "All"
    
    var body: some View {
        ZStack {
                VStack {
                    Spacer(minLength: 150)
                    GridView(selectedCategory: selectedCategory)
                }
                
                VStack {
                    HStack {
                        Text("𖡼")
                            .font(.system(size: 100))
                            .padding(.trailing, 8)
                        Text("Beautiful Things")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                    }
                    Spacer()
                }

            
        }
        .ornament(attachmentAnchor: .scene(.bottom), ornament: {
            NavigationView(selectedCategory: $selectedCategory)
                .padding()
                .glassBackgroundEffect()
        })
        .padding()
        
    }
}

