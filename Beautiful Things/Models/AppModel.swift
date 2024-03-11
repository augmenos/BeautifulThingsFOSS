//
//  AppModel.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import SwiftUI

@Observable
class AppModel {
    var showLaunchScreen = true
    
    var beautifulThings: [BeautifulThing] = []
    var userFavorites: [BeautifulThing] = []
    
    var titleText: String = ""
    var isTitleFinished: Bool = false
    var finalTitle: String = "Hello Beautiful..."
    
    init() {
        self.beautifulThings = loadBeautifulThings()
        self.loadFavorites()
    }
    
    func filterItems(forCategory category: String) -> [BeautifulThing] {
        switch category.lowercased() {
        case "new":
            return beautifulThings
        case "all":
            return beautifulThings.sorted(by: { $0.title < $1.title })
        case "featured":
            return beautifulThings.filter { $0.featured == "Yes" }
        case "animated":
            return beautifulThings.filter { $0.animated == "Yes" }
        case "loved":
            return userFavorites.filter { $0.isFavorited }
        default:
            return beautifulThings.filter { $0.category.lowercased() == category.lowercased() }
        }
    }
    
    func toggleFavorite(_ beautifulThing: BeautifulThing) {
        if let index = beautifulThings.firstIndex(where: { $0.filename == beautifulThing.filename }) {
            beautifulThings[index].isFavorited.toggle()
            if beautifulThings[index].isFavorited {
                userFavorites.append(beautifulThings[index])
            } else {
                userFavorites.removeAll { $0.filename == beautifulThing.filename }
            }
            saveFavorites()
            print("DEBUG: User favorites count: \(userFavorites.count)")
        }
    }
    
    private func saveFavorites() {
        // Convert userFavorites to an array of filenames
        let filenames = userFavorites.map { $0.filename }
        // Save the filenames array to UserDefaults
        UserDefaults.standard.set(filenames, forKey: "userFavorites")
    }
    
    private func loadFavorites() {
        // Load the filenames array from UserDefaults
        if let filenames = UserDefaults.standard.array(forKey: "userFavorites") as? [String] {
            // Update the isFavorited property for each item in beautifulThings
            for filename in filenames {
                if let index = beautifulThings.firstIndex(where: { $0.filename == filename }) {
                    beautifulThings[index].isFavorited = true
                    userFavorites.append(beautifulThings[index])
                }
            }
        }
    }
}
