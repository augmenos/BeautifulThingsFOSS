//
//  SearchView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/22/24.
//

import SwiftUI

struct SearchView: View {
    @Environment(AppModel.self) private var appModel
    @State private var searchText = ""
    
    var filteredItems: [BeautifulThing] {
        let items = appModel.beautifulThings
            .filter { searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText) || $0.subtitle.localizedCaseInsensitiveContains(searchText) }
            .sorted { $0.title < $1.title }
        print("Total items: \(appModel.beautifulThings.count), Filtered items: \(items.count)")
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
            
            List(filteredItems) { item in
                NavigationLink(destination: CardView(beautifulThing: item)) {
                    HStack {
                        Text(item.subtitle)
                        Text(item.title)
                            .bold()
                    }
                    .foregroundStyle(.primary)
                    .padding(.vertical, 8)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .listRowSeparator(.visible, edges: .bottom)
            }
        }
        .background(.clear)
        .padding(.horizontal)
    }
}
