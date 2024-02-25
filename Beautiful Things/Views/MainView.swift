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
//                .frame(width: 1075, height: 950)
                .glassBackgroundEffect()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            HStack {
                NavigationStack {
                    HStack {
                        SearchView()
                            .glassBackgroundEffect()
                            .frame(width: 600)
//                        Spacer()
                    }
                }
                .glassBackgroundEffect()
                .frame(width: 600)
                //                Spacer()
            }
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            AboutView()
                .frame(width: 600)
                .glassBackgroundEffect()
                .tabItem {
                    Label("About", systemImage: "ellipsis.circle")
                }
        }
    }
}
