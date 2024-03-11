//
//  MenuView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/28/24.
//

import SwiftUI

struct MenuView: View {
    @Environment(AppModel.self) private var appModel
    @State private var selectedCategory: String? = "Featured"
    @State private var isLargeGridView: Bool = true
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedCategory) {
                Section(header: Text("For You").foregroundColor(.gray)) {
                    NavigationLink("Featured", value: "Featured")
                    NavigationLink("Animated", value: "Animated")
                    NavigationLink("New", value: "New")
                }
                
                Section(header: Text("Categories").foregroundColor(.gray)) {
                    ForEach(uniqueCategories.sorted(), id: \.self) { category in
                        NavigationLink(category, value: category)
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Beautiful Things")
        } detail: {
            VStack {
                HStack {
                    Text(" ")
                        .font(.system(size: 100))
                        .padding(.trailing, 8)
                    Text("Pinch, hold, and drag to bring Things into your world.")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                }
                .padding()
                
                if let selectedCategory = selectedCategory {
                        GridLargeView(selectedCategory: selectedCategory)
                }
            }
            .padding(.top, -100)
        }
        .navigationDestination(for: String.self) { category in
                GridLargeView(selectedCategory: category)
        }
    }
    
    private var uniqueCategories: Set<String> {
        Set(appModel.beautifulThings.map { $0.category })
    }
}
