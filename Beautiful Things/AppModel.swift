//
//  AppModel.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import SwiftUI

@Observable
class AppModel {
    var beautifulThings: [BeautifulThing] = []
    var currentCategoryItems: [BeautifulThing] = []

        func fetchCategoryItems(url: String) {
            BeautifulThingFetcher.fetchBeautifulThings(url: url) { fetchedItems in
                DispatchQueue.main.async {
                    self.currentCategoryItems = fetchedItems
                }
            }
        }

}
