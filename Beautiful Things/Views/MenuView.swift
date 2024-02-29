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
    @State private var isLargeGridView: Bool = true /// Working but unable to autoresize main window.
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedCategory) {
                Section(header: Text("For You")) {
                    NavigationLink("Featured", value: "Featured") /// Note to self: fetch data from URL already sorted by new?
                    NavigationLink("New", value: "New")
 //                   NavigationLink("Random", value: "All") /// Randomizes
  //                  NavigationLink("All", value: "All") /// Alphabetical
                }
                
                Section(header: Text("Categories")) {
                    /// Reminder to self: this may not work for categories with multiple words, i.e. "Pop Culture".
                    ForEach(uniqueCategories.sorted(), id: \.self) { category in
                        NavigationLink(category, value: category)
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Things")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        isLargeGridView.toggle()
//                    }) {
//                        Image(systemName: isLargeGridView ? "square.grid.2x2.fill" : "square.grid.2x2")
//                    }
//                }
//            }
        } detail: {
            VStack {
                HStack {
                    Text("𖡼")
                        .font(.system(size: 100))
                        .padding(.trailing, 8)
                    Text("Beautiful Things")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                }
                .padding()
                
                if let selectedCategory = selectedCategory {
                    if isLargeGridView {
                        GridLargeView(selectedCategory: selectedCategory)
                    } else {
                        GridView(selectedCategory: selectedCategory)
                    }
                }
            }
            .padding(.top, -100)
        }
        .navigationDestination(for: String.self) { category in
            if isLargeGridView {
                GridLargeView(selectedCategory: category)
            } else {
                GridView(selectedCategory: category)
            }
        }
    }
    
    private var uniqueCategories: Set<String> {
        Set(appModel.beautifulThings.map { $0.category })
    }
}
