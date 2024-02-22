//
//  NavigationView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import SwiftUI

struct NavigationView: View {
    @Environment(AppModel.self) private var appModel
    @Binding var selectedCategory: String
    
    var body: some View {
        HStack {
            CategoryButton(category: "All", selectedCategory: $selectedCategory)
            CategoryButton(category: "New", selectedCategory: $selectedCategory)
            CategoryButton(category: "Culture", selectedCategory: $selectedCategory)
            CategoryButton(category: "Tech", selectedCategory: $selectedCategory)
            CategoryButton(category: "Nature", selectedCategory: $selectedCategory)
            CategoryButton(category: "Other", selectedCategory: $selectedCategory)
            
            Divider()
                .background(.thinMaterial)
                .frame(height: 20)
                .padding(.horizontal, 8)
            
            
            Button {
                selectedCategory = "Loved"
            } label: {
                Image(systemName: "heart.fill")
                Text("Loved")
            }
            .foregroundStyle(selectedCategory == "Loved" ? Color.black : Color.primary)
            .background(selectedCategory == "Loved" ? Color.primary : Color.clear)
            .glassBackgroundEffect()
            .padding(.horizontal, 5)
        }
    }
}

struct CategoryButton: View {
    var category: String
    @Binding var selectedCategory: String
    
    var body: some View {
        Button {
            selectedCategory = category
        } label: {
            Text(category)
                .frame(width: 60)
        }
        .foregroundStyle(selectedCategory == category ? Color.black : Color.primary)
        .background(selectedCategory == category ? Color.primary : Color.clear)
        .glassBackgroundEffect()
        .padding(.horizontal, 5)
    }
}
