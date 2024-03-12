//
//  SearchView.swift
//  Beautiful Things
//
//  A search view that filters through the beautifulThings array.
//

import SwiftUI

struct SearchView: View {
    @Environment(AppModel.self) private var appModel
    
    // The initial search, i.e. an empty string.
    @State private var searchText = ""
    
    var filteredItems: [BeautifulThing] {
        let items = appModel.beautifulThings
            .filter {
                searchText.isEmpty ||
                $0.title.localizedCaseInsensitiveContains(searchText) || // Searches for words in the title.
                $0.subtitle.localizedCaseInsensitiveContains(searchText) || // Searches for words in the subtitle.
                $0.descriptionText.localizedCaseInsensitiveContains(searchText) // Searches for words in the description.
            }
            .sorted { $0.title < $1.title }
        return items
    }
    
    var body: some View {
        VStack {
            TextField("Search", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .padding()
                .padding(.top, 10)
                .overlay(
                    HStack {
                        Spacer()
                        if !searchText.isEmpty {
                            Button(action: { searchText = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.top, 8)
                            .padding(.trailing, 25)
                            .buttonStyle(.plain)
                        }
                    }
                )
            
            // A list that displays the results of the search.
            List {
                ForEach(filteredItems) { item in
                    // Each result is a link to a CardView for that beautiful thing.
                    NavigationLink(destination: CardView(beautifulThing: item)) {
                        HStack {
                            Text(item.subtitle)
                            Text(item.title)
                                .bold()
                        }
                        .foregroundStyle(.primary)
                        .padding(.vertical, 8)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding(.horizontal)
    }
}
