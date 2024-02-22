//
//  MainView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/22/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            NavigationStack {
                SearchView()
            }
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            // Placeholder for About view
            Text("About View")
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }
    }
}
