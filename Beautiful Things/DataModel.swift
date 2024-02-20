//
//  DataModel.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import Foundation
import SwiftSoup

struct BeautifulThing: Hashable {
    var title: String
    var subtitle: String
    var filename: String
    var category: String
    var year: String
    var description: NSAttributedString
    var attribution: String
    var license: String
    var imageURL: String
}

func fetchBeautifulThings(url: String, category: String, completion: @escaping ([BeautifulThing]) -> Void) {
    guard let url = URL(string: url) else {
        print("Invalid URL")
        return
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
            return
        }

        do {
            let html = String(decoding: data, as: UTF8.self)
            let document = try SwiftSoup.parse(html)
            
            // Adjust the selector based on the category
            let urlString = url.absoluteString
            let itemsSelector: String
            if urlString.contains("/category/new") {
                itemsSelector = "div.framer-5sx04j-container"
            } else if urlString.contains("/category/other") {
                itemsSelector = "div.framer-112t49g-container"
            } else if urlString.contains("/category/culture") {
                itemsSelector = "div.framer-1l927yc-container"
            } else if urlString.contains("/category/tech") {
                itemsSelector = "div.framer-d5i59q-container"
            } else if urlString.contains("/category/nature") {
                itemsSelector = "div.framer-81wovf-container"
            } else {
                itemsSelector = "div.framer-ad5wfq-container"
            }
            
            let items = try document.select(itemsSelector)
            var beautifulThings: [BeautifulThing] = []
            
            // Parsing logic (may need adjustments based on category-specific HTML structure)
            for item in items {
                let title = try item.select("div.framer-u2tus0 > p").first()?.text() ?? ""
                let subtitle = try item.select("div.framer-1l605sw > p").first()?.text() ?? ""
                let year = try item.select("div.framer-b015mz > p").first()?.text() ?? ""
                let category = try item.select("div.framer-wlop1v > p").first()?.text() ?? ""
                let link = try item.select("a").first()?.attr("href") ?? ""
                let imageURL = try item.select("img").first()?.attr("src") ?? ""
                
                let beautifulThing = BeautifulThing(
                    title: title,
                    subtitle: subtitle,
                    filename: link,
                    category: category,
                    year: year,
                    description: NSAttributedString(string: ""),
                    attribution: "",
                    license: "",
                    imageURL: imageURL
                )
                beautifulThings.append(beautifulThing)
            }
            
            DispatchQueue.main.async {
                completion(beautifulThings)
            }
        } catch {
            print("Error parsing HTML: \(error.localizedDescription)")
        }
    }
    task.resume()
}
