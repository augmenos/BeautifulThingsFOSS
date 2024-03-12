//
//  AppModel.swift
//  Beautiful Things
//
//  The app's main model.
//

import SwiftUI

@Observable
class AppModel {
    var showLaunchScreen = true
    
    var beautifulThings: [BeautifulThing] = []
    var userFavorites: [BeautifulThing] = []
    
    init() {
        self.beautifulThings = loadBeautifulThings()
        self.loadFavorites()
    }
    
    // A method that filters through predefined categories.
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
    
    // A method to toggle and save favorites/loved using the filename as the unique identifier for each thing.
    func toggleFavorite(_ beautifulThing: BeautifulThing) {
        if let index = beautifulThings.firstIndex(where: { $0.filename == beautifulThing.filename }) {
            beautifulThings[index].isFavorited.toggle()
            if beautifulThings[index].isFavorited {
                userFavorites.append(beautifulThings[index])
            } else {
                userFavorites.removeAll { $0.filename == beautifulThing.filename }
            }
            saveFavorites()
        }
    }
    
    // A method to save user favorites to UserDefaults.
    private func saveFavorites() {
        // Convert userFavorites to an array of filenames.
        let filenames = userFavorites.map { $0.filename }
        // Save the filenames array to UserDefaults.
        UserDefaults.standard.set(filenames, forKey: "userFavorites")
    }
    
    // A method to load user favorites.
    private func loadFavorites() {
        // Load the filenames array from UserDefaults.
        if let filenames = UserDefaults.standard.array(forKey: "userFavorites") as? [String] {
            // Update the isFavorited property for each item in beautifulThings.
            for filename in filenames {
                if let index = beautifulThings.firstIndex(where: { $0.filename == filename }) {
                    beautifulThings[index].isFavorited = true
                    userFavorites.append(beautifulThings[index])
                }
            }
        }
    }
}
