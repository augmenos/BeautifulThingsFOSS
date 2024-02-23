//
//  GridView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import SwiftUI
import RealityKit

struct CardView: View {
    @Environment(AppModel.self) private var appModel
    @ObservedObject var beautifulThing: BeautifulThing
    @State private var localFileURL: URL?
    @State private var showSheet = false
    @State private var isARQuickLookLoaded = false

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(beautifulThing.category)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    Spacer()
                    
                    Button {
                        appModel.toggleFavorite(beautifulThing)
                    } label: {
                        Image(systemName: beautifulThing.isFavorited ? "heart.fill" : "heart")
                            .font(.system(size: 25))
                            .foregroundStyle(.primary)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.secondary)
                    .symbolRenderingMode(.monochrome)
                }
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(beautifulThing.subtitle)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Text(beautifulThing.title)
                            .font(.title3)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Button {
                            showSheet = true
                        } label: {
                            VStack(alignment: .trailing) {
                                Image(systemName: "arrow.up.right")
                                    .font(.callout)
                                    .foregroundStyle(.secondary)
                                    .padding(.bottom, 2)
                                Text(beautifulThing.year)
                                    .font(.callout)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .buttonStyle(.plain)

                    }
                }
                .padding(.bottom, 30)
                
            }
            .padding(30)
            .background(.thinMaterial)
            .glassBackgroundEffect()
//            .background(.clear)
            //            .backgroundStyle(.primary)
//            .padding(30)
            .frame(width: 300, height: 300)
            //            .glassBackgroundEffect()
            
            /// ARQuickLook Layer
            
            if let fileURL = localFileURL {
                           ARQuickLookView(fileURL: fileURL)
                               .frame(width: 300, height: 300)
                               .onAppear {
                                   isARQuickLookLoaded = true // Set to true when ARQuickLookView appears
                               }
                       } else {
                           // Show a ProgressView while the ARQuickLookView is loading
                           ProgressView()
                               .scaleEffect(2)
                               .frame(width: 300, height: 300)
                       }
            
//            if let fileURL = localFileURL {
//                ARQuickLookView(fileURL: fileURL)
////                    .background(.thinMaterial)
////                    .glassBackgroundEffect()
//                    .frame(width: 300, height: 300)
//            }
//            
            // Better Loading View?
//                        VStack {
//                            AsyncImage(url: URL(string: beautifulThing.imageURL)) { image in
//                                image
//                                    .resizable()
//                                    .scaledToFit()
//                            } placeholder: {
//                                ProgressView()
//                            }
//                            .frame(width: 250, height: 130)
//                            .background(.thinMaterial)
//                            .padding(.bottom, 40)
//                        }
            
        }
        .sheet(isPresented: $showSheet) {
            DescriptionView(showSheet: $showSheet, beautifulThing: beautifulThing)
        }
        .onAppear {
            downloadUSDZFile()
        }
    }
    
    private func downloadUSDZFile() {
        guard let remoteURL = URL(string: beautifulThing.filename) else { return }
        
        let task = URLSession.shared.downloadTask(with: remoteURL) { tempLocalURL, response, error in
            if let tempLocalURL = tempLocalURL, error == nil {
                // Move the file to a permanent location
                let fileManager = FileManager.default
                let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileName = remoteURL.lastPathComponent
                let permanentLocalURL = documentsDirectory.appendingPathComponent(fileName)
                
                do {
                    // If the file already exists, remove it before moving the new file
                    if fileManager.fileExists(atPath: permanentLocalURL.path) {
                        try fileManager.removeItem(at: permanentLocalURL)
                    }
                    try fileManager.moveItem(at: tempLocalURL, to: permanentLocalURL)
                    
                    DispatchQueue.main.async {
                        self.localFileURL = permanentLocalURL
                    }
                } catch {
                    print("Error moving file: \(error)")
                }
            }
        }
        
        task.resume()
    }
}
