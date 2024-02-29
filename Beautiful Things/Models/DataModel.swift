//
//  DataModel.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import Foundation
import SwiftSoup

class BeautifulThing: Identifiable, ObservableObject, Hashable, Equatable {
    var id: String { filename }
    var title: String
    var subtitle: String
    var filename: String
    var category: String
    var featured: String
    var year: String
    var imageURL: String
    
    @Published var isFavorited: Bool = false
    var descriptionText: String
    var modelName: String
    var modelAuthor: String
    var license: String
    
    init(title: String, subtitle: String, filename: String, category: String, year: String, imageURL: String, descriptionText: String, modelName: String, modelAuthor: String, license: String, featured: String) {
        self.title = title
        self.subtitle = subtitle
        self.filename = filename
        self.category = category
        self.year = year
        self.imageURL = imageURL
        
        self.descriptionText = descriptionText
        self.modelName = modelName
        self.modelAuthor = modelAuthor
        self.license = license
        self.featured = featured
    }
    
    static func == (lhs: BeautifulThing, rhs: BeautifulThing) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
