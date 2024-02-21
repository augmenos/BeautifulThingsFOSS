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
                ForEach(appModel.currentCategoryItems) { item in
                    CardView(beautifulThing: item)
                }
            }
            .padding()
        }
    }
}
