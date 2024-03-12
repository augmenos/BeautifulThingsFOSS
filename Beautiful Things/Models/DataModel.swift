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

//
//class BeautifulThing: Identifiable, ObservableObject, Codable, Hashable, Equatable {
//    var id: String { filename }
//    var title: String
//    var subtitle: String
//    var filename: String
//    var category: String
//    var featured: String
//    var animated: String
//    var year: String
//    var image: String
//    
//    @Published var isFavorited: Bool = false
//    
//    var descriptionText: String
//    var modelName: String
//    var modelAuthor: String
//    var license: String
//    
//    init(title: String, subtitle: String, filename: String, category: String, featured: String, animated: String, year: String, image: String, descriptionText: String, modelName: String, modelAuthor: String, license: String) {
//        self.title = title
//        self.subtitle = subtitle
//        self.filename = filename
//        self.category = category
//        self.featured = featured
//        self.animated = animated
//        self.year = year
//        self.image = image
//        
//        self.descriptionText = descriptionText
//        self.modelName = modelName
//        self.modelAuthor = modelAuthor
//        self.license = license
//    }
//    
//    static func == (lhs: BeautifulThing, rhs: BeautifulThing) -> Bool {
//        return lhs.id == rhs.id
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}
