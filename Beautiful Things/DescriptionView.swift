//
//  DescriptionView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/23/24.
//

import SwiftUI
import SwiftSoup

struct DescriptionView: View {
    @Binding var showSheet: Bool
    var beautifulThing: BeautifulThing
    @State private var descriptionText: String = ""
    @State private var modelName: String = ""
    @State private var modelAuthor: String = ""
    @State private var license: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(beautifulThing.subtitle + " " + beautifulThing.title)
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .padding(.top, 15)
                }
                
                ScrollView {
                    Text(descriptionText)
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    
                    Text("Model based on \(beautifulThing.subtitle + " " + beautifulThing.title) by \(modelAuthor)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    Text("Licensed under \(license)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .frame(alignment: .leading)
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        print("Button: Close DescriptionView")
                        showSheet = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                            .font(.system(size: 40))
                    }
                    .clipShape(Circle())
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.top, 8)
                .padding(.trailing, 8)
                
                Spacer()
            }
        }
        .frame(width: 500, height: 300)
        .padding(30)
        .onAppear {
            fetchBeautifulThingInfo(beautifulThing: beautifulThing) { description, modelName, modelAuthor, license in
                self.descriptionText = description
                self.modelName = modelName
                self.modelAuthor = modelAuthor
                self.license = license
            }
        }
    }
}

func fetchBeautifulThingInfo(beautifulThing: BeautifulThing, completion: @escaping (String, String, String, String) -> Void) {
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
