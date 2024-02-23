//
//  GridView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import SwiftUI

struct GridView: View {
    @Environment(AppModel.self) private var appModel
    var selectedCategory: String
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 50) {
                ForEach(appModel.filterItems(forCategory: selectedCategory)) { item in
                    CardView(beautifulThing: item)
                }
            }
            .padding()
        }
    }
}

/// Crashed app but gird worked better? 
//var body: some View {
//    ScrollView {
//        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 50) {
//            ForEach(appModel.beautifulThings.filter { item in
//                selectedCategory == "All" || item.category.lowercased() == selectedCategory.lowercased() || (selectedCategory == "Loved" && item.isFavorited)
//            }.sorted(by: { $0.title < $1.title }), id: \.id) { item in
//                CardView(beautifulThing: item)
//            }
//        }
//        .padding()
//    }
//}
