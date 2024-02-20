//
//  NavigationView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import SwiftUI

struct NavigationView: View {
    @Binding var selectedCategory: String
    @Binding var beautifulThings: [BeautifulThing]

    var body: some View {
        HStack {
            CategoryButton(category: "All", selectedCategory: $selectedCategory, beautifulThings: $beautifulThings)
            CategoryButton(category: "New", selectedCategory: $selectedCategory, beautifulThings: $beautifulThings)
            CategoryButton(category: "Culture", selectedCategory: $selectedCategory, beautifulThings: $beautifulThings)
            CategoryButton(category: "Tech", selectedCategory: $selectedCategory, beautifulThings: $beautifulThings)
            CategoryButton(category: "Nature", selectedCategory: $selectedCategory, beautifulThings: $beautifulThings)
            CategoryButton(category: "Other", selectedCategory: $selectedCategory, beautifulThings: $beautifulThings)
            

            Button {
                print("Button: Favorites")
            } label: {
                Image(systemName: "star.fill")
                Text("Favorites")
            }
            .glassBackgroundEffect()
            .padding(.leading, 25)
        }
    }
}

struct CategoryButton: View {
    var category: String
    @Binding var selectedCategory: String
    @Binding var beautifulThings: [BeautifulThing]

    var body: some View {
        Button {
            selectedCategory = category
            let url = category == "All" ? "https://beautifulthings.xyz" : "https://beautifulthings.xyz/category/\(category.lowercased())"
            fetchBeautifulThings(url: url, category: category) { fetchedBeautifulThings in
                beautifulThings = fetchedBeautifulThings
            }
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
