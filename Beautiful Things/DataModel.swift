//
//  DataModel.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import Foundation
import SwiftSoup

class BeautifulThing: Identifiable, ObservableObject, Hashable { // Hashable, Equatable ?
    var id = UUID()
    var title: String
    var subtitle: String
    var filename: String
    var category: String
    var year: String
    var description: NSAttributedString
    var attribution: String
    var license: String
    var imageURL: String
    @Published var isFavorited: Bool = false
    
    init(title: String, subtitle: String, filename: String, category: String, year: String, description: NSAttributedString, attribution: String, license: String, imageURL: String) {
        self.title = title
        self.subtitle = subtitle
        self.filename = filename
        self.category = category
        self.year = year
        self.description = description
        self.attribution = attribution
        self.license = license
        self.imageURL = imageURL
    }
    
    static func == (lhs: BeautifulThing, rhs: BeautifulThing) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}
