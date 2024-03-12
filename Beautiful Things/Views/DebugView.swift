//
//  DebugView.swift
//  Beautiful Things
//
//  A debug view to test the JSON decoder and loading.
//

import SwiftUI

struct DebugView: View {
    var body: some View {
        Button {
            let beautifulThings = loadBeautifulThings()
            for thing in beautifulThings {
                print("Title: \(thing.title), Subtitle: \(thing.subtitle), Filename: \(thing.filename), Category: \(thing.category), Featured: \(thing.featured), Animated: \(thing.animated), Year: \(thing.year), Image: \(thing.image), isFavorited: \(thing.isFavorited), Description: \(thing.descriptionText), Model Name: \(thing.modelName), Model Author: \(thing.modelAuthor), License: \(thing.license)")
            }
        } label: {
            Text("Print JSON")
        }
    }
}
