//
//  DataFetcher.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import Foundation
import SwiftSoup

class BeautifulThingFetcher {
    static func fetchBeautifulThings(url: String, completion: @escaping ([BeautifulThing]) -> Void) {
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
                
//                 let itemsSelector = "div.framer-1vq31ht-container > div.framer-yJoAj" /// Production
                let itemsSelector = "div.framer-1gmgbs9" /// Development
                
                let items = try document.select(itemsSelector)
                var beautifulThings: [BeautifulThing] = []
                
                for item in items {
                    let title = try item.select("div.framer-u2tus0 > p").text()
                    let subtitle = try item.select("div.framer-1l605sw > p").text()
                    let year = try item.select("div.framer-b015mz > p").text()
                    let category = try item.select("div.framer-wlop1v > p").text()
                    let link = try item.select("div.framer-1kzr64t > div > div > a").attr("href")
                    let imageURL = try item.select("div.framer-1kzr64t > div > div > a > img").attr("src")
                    
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
                
                /// Helpful Debug Stats
                print("DEBUG: Fetched \(beautifulThings.count) beautiful things.")
                let dataSize = Double(data.count) / 1024.0 / 1024.0 // Convert to megabytes
                print("DEBUG: Fetched data size \(dataSize) MB")
                
                DispatchQueue.main.async {
                    completion(beautifulThings)
                }
            } catch {
                print("Error parsing HTML: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
