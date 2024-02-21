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
                
                NavigationView(selectedCategory: selectedCategory)
                    .padding(.bottom, 30)
                
                if selectedCategory == "Favorites" {
                    FavoritesView()
                        .padding(.top, 30)
                } else {
                    GridView(selectedCategory: selectedCategory)
                        .padding(.top, 30)
                    
                }
                
            }
            
            VStack {
                HStack {
                    Text("𖡼")
                        .font(.system(size: 120)) // Messes up placement of NavigationView
                        .padding(.trailing, 20)
                    Text("Beautiful Things")
                        .font(.extraLargeTitle)
                        .fontWeight(.medium)
                }
                
                Spacer()
            }
        }
        
        
        .padding()
        .onAppear {
            appModel.fetchCategoryItems(url: "https://beautifulthings.xyz")
        }
    }
}

