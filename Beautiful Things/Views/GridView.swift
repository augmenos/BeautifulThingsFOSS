//
//  GridView.swift
//  Beautiful Things
//
//  A ScrollView presenting each CardView for the specific category in a column of 2.
//

import SwiftUI

struct GridView: View {
    @Environment(AppModel.self) private var appModel
    var selectedCategory: String
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 50) {
                ForEach(appModel.filterItems(forCategory: selectedCategory)) { item in
                    CardView(beautifulThing: item)
                }
            }
            .padding()
        }
    }
}
