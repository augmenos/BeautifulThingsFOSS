//
//  CardView.swift
//  Beautiful Things
//
//  This view displays a card UI for each "Beautiful Thing", with interactions such as favoriting, viewing details, and displaying a 3D model.
//
//

import SwiftUI
import RealityKit

// Represents the state of a manipulation gesture.
struct ManipulationState {
    var transform: AffineTransform3D = .identity
    var active: Bool = false
}

struct CardView: View {
    // Gesture state for manipulation.
    @GestureState var manipulationState = ManipulationState()
    // Access the shared application model environment.
    @Environment(AppModel.self) private var appModel
    // The beautiful thing being displayed.
    @ObservedObject var beautifulThing: BeautifulThing
    // Local file URL for the beautiful thing's model.
    @State private var localFileURL: URL?
    // Controls visibility of a sheet for additional details.
    @State private var showSheet = false
    // Controls the visibility of the preview.
    @State private var isPreviewVisible = false
    // Controls highlighting of the card.
    @State private var showHighlight = false
    // Controls the visibility of the instructional message.
    @State private var showMessage = false
    // Controls the wiggle animation effect.
    @State private var wiggle = false

    var body: some View {
        ZStack {
            // Card main content.
            VStack {
                // Top row with category and favorite button.
                HStack {
                    Text(beautifulThing.category)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    Spacer()
                    // Favorite button.
                    Button {
                        appModel.toggleFavorite(beautifulThing)
                    } label: {
                        Image(systemName: beautifulThing.isFavorited ? "heart.fill" : "heart")
                            .padding(10)
                            .font(.system(size: 25))
                            .foregroundStyle(.primary)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.secondary)
                    .symbolRenderingMode(.monochrome)
                }
                
                Spacer()
                // Instructional message.
                if showMessage {
                    Text("Pinch and Hold")
                        .bold()
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 1), value: showMessage)
                }
                
                // Middle row with subtitle, title, and share button.
                HStack {
                    VStack(alignment: .leading) {
                        Text(beautifulThing.subtitle)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Text(beautifulThing.title)
                            .font(.title3)
                    }
                    
                    Spacer()
                    
                    // Share button.
                    VStack(alignment: .trailing) {
                        Button {
                            showSheet = true
                        } label: {
                            VStack(alignment: .trailing) {
                                Image(systemName: "arrow.up.right")
                                    .padding(10)
                                    .font(.callout)
                                    .foregroundStyle(.secondary)
                                    .padding(.bottom, 2)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(30)
            .background(.thinMaterial)
            .glassBackgroundEffect()
            .frame(width: 400, height: 400)
            // Highlight effect.
            .overlay(
                RoundedRectangle(cornerRadius: 45.0, style: .continuous)
                    .foregroundColor(showHighlight ? .gray : .clear)
                    .opacity(showHighlight ? 0.3 : 0)
                    .transition(.opacity)
                    .animation(.easeOut, value: showHighlight)
            )
            .sheet(isPresented: $showSheet) {
                DescriptionView(showSheet: $showSheet, beautifulThing: beautifulThing)
            }
            
            // 3D model display.
            VStack {
                if let localFileURL = self.localFileURL {
                    Model3D(url: localFileURL) { model in
                        model
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxDepth: 200)
                            .frame(width: 200, height: 200)
                            .padding(10)
                            .rotationEffect(.degrees(wiggle ? -1 : 1), anchor: .center)
                            .animation(.easeInOut(duration: 0.2).repeatCount(6, autoreverses: true), value: wiggle)
                    } placeholder: {
                        ProgressView()
                    }
                    .zIndex(1)
                }
            }
        }
        // Drag and drop support for the 3D model.
        .onDrag {
            let name = self.localFileURL?.deletingPathExtension().lastPathComponent.replacingOccurrences(of: "_", with: " ") ?? "Untitled"
            let itemProvider: NSItemProvider
            
            if let localFileURL = self.localFileURL, localFileURL.pathExtension == "usdz" {
                let item = NSItemProvider(contentsOf: localFileURL)
                item?.preferredPresentationSize = CGSize(width: 400, height: 400)
                item?.suggestedName = name
                itemProvider = item ?? NSItemProvider()
            } else {
                itemProvider = NSItemProvider(contentsOf: self.localFileURL) ?? NSItemProvider()
            }
            
            let userActivity = NSUserActivity(activityType: "com.apple.cocoa.touch.3dmodel")
            userActivity.isEligibleForHandoff = true
            userActivity.isEligibleForSearch = true
            userActivity.isEligibleForPublicIndexing = true
            userActivity.title = name
            
            itemProvider.registerObject(userActivity, visibility: .all)
            return itemProvider
        }
        .highPriorityGesture(DragGesture().onEnded { value in
            self.isPreviewVisible = true
        })
        .onTapGesture {
            // Trigger effects on tap.
            self.showHighlight = true
            self.wiggle = true
            self.showMessage = true
            // Schedule end of animations.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.wiggle = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showHighlight = false
                self.showMessage = false
            }
        }
        .onAppear {
            downloadUSDZFile()
        }
    }

    // Downloads and caches the USDZ file for the 3D model.
    private func downloadUSDZFile() {
        guard let remoteURL = URL(string: beautifulThing.filename) else { return }
        
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = remoteURL.lastPathComponent
        let localURL = documentsDirectory.appendingPathComponent(fileName)
        
        if fileManager.fileExists(atPath: localURL.path) {
            // Use cached version if exists.
            self.localFileURL = localURL
        } else {
            // Download and cache if not present.
            let task = URLSession.shared.downloadTask(with: remoteURL) { tempLocalURL, response, error in
                if let tempLocalURL = tempLocalURL, error == nil {
                    do {
                        try fileManager.moveItem(at: tempLocalURL, to: localURL)
                        DispatchQueue.main.async {
                            self.localFileURL = localURL
                        }
                    } catch {
                        print("Error moving file: \(error)")
                    }
                }
            }
            task.resume()
        }
        
        // Debug print for directory size.
        DispatchQueue.main.async {
            let totalDirectorySize = self.calculateTotalDirectorySize()
            print("DEBUG: Total directory size: \(totalDirectorySize) MB")
        }
    }

    // Calculates the total size of documents directory.
    private func calculateTotalDirectorySize() -> Double {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: [.fileSizeKey], options: .skipsHiddenFiles)
            let totalSize = fileURLs.reduce(0) { total, fileURL in
                if let fileSize = try? fileURL.resourceValues(forKeys: [.fileSizeKey]).fileSize {
                    return total + Double(fileSize)
                }
                return total
            }
            
            return totalSize / 1024.0 / 1024.0
        } catch {
            print("Error calculating directory size: \(error)")
            return 0
        }
    }
}

