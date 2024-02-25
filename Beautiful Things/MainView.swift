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
                            .frame(width: 450)
//                        Spacer()
                    }
                }
                .frame(width: 450)
                .background(.clear)
                .backgroundStyle(.clear)
//                Spacer()
            }
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            AboutView()
                .glassBackgroundEffect()
                .tabItem {
                    Label("About", systemImage: "ellipsis.circle")
                }
        }
    }
}
