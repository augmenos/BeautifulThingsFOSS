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
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    
    @State private var selectedCategory: String = "All"
    @State private var beautifulThings: [BeautifulThing] = []
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        VStack {
            HStack {
                Text("𖡼")
                    .font(.system(size: 120))
                    .padding(.trailing, 20)
                Text("Beautiful Things")
                    .font(.extraLargeTitle)
                    .fontWeight(.medium)
            }
            
            NavigationView(selectedCategory: $selectedCategory, beautifulThings: $beautifulThings)
            
            Spacer()
            
            GridView(beautifulThings: beautifulThings, selectedCategory: selectedCategory)
                .frame(height: 500)
            
        }
        .padding()
        .onAppear {
            fetchBeautifulThings(url: "https://beautifulthings.xyz", category: "All") { fetchedBeautifulThings in
                beautifulThings = fetchedBeautifulThings
            }
        }
    }
}
