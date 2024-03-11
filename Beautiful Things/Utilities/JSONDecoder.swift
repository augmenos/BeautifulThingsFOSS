//
//  JSONDecoder.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 3/11/24.
//

import Foundation

struct BeautifulThingsWrapper: Codable {
    var Beautiful_Things_Sample: [BeautifulThing]
}

func loadBeautifulThings() -> [BeautifulThing] {
    guard let url = Bundle.main.url(forResource: "Beautiful_Things_Sample", withExtension: "json") else {
        fatalError("JSON file not found")
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let wrapper = try decoder.decode(BeautifulThingsWrapper.self, from: data)
        return wrapper.Beautiful_Things_Sample
    } catch {
        fatalError("Error decoding JSON: \(error)")
    }
}
