//
//  NavigationView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import SwiftUI

struct NavigationView: View {
    @Environment(AppModel.self) private var appModel
    @State var selectedCategory: String
    
    var body: some View {
        HStack {
            CategoryButton(category: "All", selectedCategory: $selectedCategory)
            CategoryButton(category: "New", selectedCategory: $selectedCategory)
            CategoryButton(category: "Culture", selectedCategory: $selectedCategory)
            CategoryButton(category: "Tech", selectedCategory: $selectedCategory)
            CategoryButton(category: "Nature", selectedCategory: $selectedCategory)
            CategoryButton(category: "Other", selectedCategory: $selectedCategory)
            
            Button {
                selectedCategory = "Favorites"
            } label: {
                Image(systemName: "star.fill")
                Text("Favorites")
            }
            .foregroundStyle(selectedCategory == "Favorites" ? Color.black : Color.primary)
            .background(selectedCategory == "Favorites" ? Color.primary : Color.clear)
            .glassBackgroundEffect()
            .padding(.leading, 25)
        }
    }
}

struct CategoryButton: View {
    @Environment(AppModel.self) private var appModel
    
    var category: String
    @Binding var selectedCategory: String
    
    var body: some View {
        Button {
            selectedCategory = category
            let url = category == "All" ? "https://beautifulthings.xyz" : "https://beautifulthings.xyz/category/\(category.lowercased())"
            appModel.fetchCategoryItems(url: url)
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


//struct CategoryButton: View {
//    var category: String
//    @Binding var selectedCategory: String
//    @Environment(AppModel.self) private var appModel
//
//    var body: some View {
//        Button {
//            selectedCategory = category
//            let url = category == "All" ? "https://beautifulthings.xyz" : "https://beautifulthings.xyz/category/\(category.lowercased())"
//            appModel.fetchBeautifulThings(url: url)
//        } label: {
//            Text(category)
//                .frame(width: 60)
//        }
//        .foregroundStyle(selectedCategory == category ? Color.black : Color.primary)
//        .background(selectedCategory == category ? Color.primary : Color.clear)
//        .glassBackgroundEffect()
//        .padding(.horizontal, 5)
//    }
//}

//struct CategoryButton: View {
//    var category: String
//    @Binding var selectedCategory: String
//    @Environment(AppModel.self) private var appModel
//
//    var body: some View {
//        Button {
//            selectedCategory = category
//            let url = category == "All" ? "https://beautifulthings.xyz" : "https://beautifulthings.xyz/category/\(category.lowercased())"
//            BeautifulThingFetcher.fetchBeautifulThings(url: url, category: category) { fetchedBeautifulThings in
//                appModel.beautifulThings = fetchedBeautifulThings
//            }
//        } label: {
//            Text(category)
//                .frame(width: 60)
//        }
//        .foregroundStyle(selectedCategory == category ? Color.black : Color.primary)
//        .background(selectedCategory == category ? Color.primary : Color.clear)
//        .glassBackgroundEffect()
//        .padding(.horizontal, 5)
//    }
//}
