//
//  DataModel.swift
//  Beautiful Things
//
//  The data model for Beautiful Things. Must conform to Identifiable, ObservableObject, Codable, Hashable, and Equatable in order to search, filter, save favorites, etc.
//

import Foundation

class BeautifulThing: Identifiable, ObservableObject, Codable, Hashable, Equatable {
    var id: String { filename }
    var title: String
    var subtitle: String
    var filename: String
    var category: String
    var featured: String
    var animated: String
    var year: String
    var image: String
    var isFavorited: Bool
    var descriptionText: String
    var modelName: String
    var modelAuthor: String
    var license: String

    static func == (lhs: BeautifulThing, rhs: BeautifulThing) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
