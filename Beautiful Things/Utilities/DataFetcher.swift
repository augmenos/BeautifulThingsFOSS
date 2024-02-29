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
                let itemsSelector = "div.framer-mnas8g" /// Development
                
                let items = try document.select(itemsSelector)
                var beautifulThings: [BeautifulThing] = []
                
                for item in items {
                    //                    print(try item.outerHtml())
                    
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
                        imageURL: imageURL,
                        
                        descriptionText: "",
                        modelName: "",
                        modelAuthor: "",
                        license: ""
                    )
                    beautifulThings.append(beautifulThing)
                }
                
                let group = DispatchGroup()
                
                for beautifulThing in beautifulThings {
                    group.enter()
                    fetchBeautifulThingInfo(beautifulThing: beautifulThing) { description, modelName, modelAuthor, license in
                        beautifulThing.descriptionText = description
                        beautifulThing.modelName = modelName
                        beautifulThing.modelAuthor = modelAuthor
                        beautifulThing.license = license
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    completion(beautifulThings)
                }
                
                /// Helpful Debug Stats
                /// Seems to be fetching 4x for each item but size is minimal so shouldn't cause issue?
                print("DEBUG: Fetched \(beautifulThings.count) beautiful things.")
                let dataSize = Double(data.count) / 1024.0 / 1024.0
                print("DEBUG: Fetched data size \(dataSize) MB")
                
                beautifulThings.enumerated().forEach { index, beautifulThing in
                    print("DEBUG: Fetched \(beautifulThing.title) [\(index)]")
                }
                
                
            } catch {
                print("Error parsing HTML: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    static func fetchBeautifulThingInfo(beautifulThing: BeautifulThing, completion: @escaping (String, String, String, String) -> Void) {
        let filename = beautifulThing.filename
        let modelName = filename.components(separatedBy: "/models/").last?.components(separatedBy: ".usdz").first?.lowercased() ?? ""
        let url = URL(string: "https://beautifulthings.xyz/things/\(modelName)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let html = String(decoding: data, as: UTF8.self)
                let document = try SwiftSoup.parse(html)
                
                let description = try document.select("div.framer-1368l0r").text()
                let modelName = try document.select("div.framer-1mn1rta").text()
                let modelAuthor = try document.select("div.framer-ebdazr").text()
                let license = try document.select("div.framer-1eogcsr").text()
                
                DispatchQueue.main.async {
                    completion(description, modelName, modelAuthor, license)
                }
            } catch {
                print("Error parsing HTML: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
