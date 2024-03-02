//
//  CardView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//
import SwiftUI
import RealityKit
struct ManipulationState {
  var transform: AffineTransform3D = .identity
  var active: Bool = false
}

struct CardView: View {
    @GestureState var manipulationState = ManipulationState()
    @Environment(AppModel.self) private var appModel
    @ObservedObject var beautifulThing: BeautifulThing
    @State private var localFileURL: URL?
    @State private var showSheet = false
    @State private var userActivity: NSUserActivity? = nil
    @State private var isQuickLookVisible = false
    @State private var selectedModelURL: URL? = nil
    @State private var isPreviewVisible = false

    var body: some View {
           ZStack {
               VStack {
                   if localFileURL != nil {
                       AsyncImage(url: URL(string: beautifulThing.imageURL)) { image in
                           image
                               .resizable()
                               .scaledToFit()
                               .frame(width: 400, height: 400)
                               .onDrag {
                                   let itemProvider = NSItemProvider(contentsOf: self.localFileURL) ?? NSItemProvider()
                                   let userActivity = NSUserActivity(activityType: "com.apple.cocoa.touch.3dmodel")
                                   userActivity.isEligibleForHandoff = true
                                   userActivity.isEligibleForSearch = true
                                   userActivity.isEligibleForPublicIndexing = true
                                   userActivity.title = beautifulThing.title
                                   itemProvider.registerObject(userActivity, visibility: .all)
                                return itemProvider
                               }
                               .highPriorityGesture(DragGesture().onEnded { value in
                        
                                       self.isPreviewVisible = true
                                   
                               })
                           
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 400, height: 350)
                    .background(.clear)
                    .padding(.bottom, 45)
                }
            }
            .background(.thinMaterial)
            .glassBackgroundEffect()
            .onAppear {
                if localFileURL != nil {
                    self.userActivity = NSUserActivity(activityType: "com.apple.cocoa.touch.3dmodel")
                    self.userActivity?.isEligibleForHandoff = true
                    self.userActivity?.isEligibleForSearch = true
                    self.userActivity?.isEligibleForPublicIndexing = true
                    self.userActivity?.title = beautifulThing.title
                    self.userActivity?.becomeCurrent()
                }
            }
            
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
                            .padding(10)
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
                                    .padding(10)
                                    .font(.callout)
                                    .foregroundStyle(.secondary)
                                    .padding(.bottom, 2)
                                //                                Text(beautifulThing.year)
                                //                                    .font(.callout)
                                //                                    .foregroundStyle(.secondary)
                            }
                        }
                        .buttonStyle(.plain)
                       
                        
                    }
                }
                
                
            }
            .padding(30)
            //            .background(.clear)
            //            .opacity(0.01)
            //            .glassBackgroundEffect()
            .frame(width: 400, height: 400)
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
        
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = remoteURL.lastPathComponent
        let localURL = documentsDirectory.appendingPathComponent(fileName)
        
        if fileManager.fileExists(atPath: localURL.path) {
            /// File already exists, use the cached version
            /// Future consideration: if USDZ file is updated, it wont' fetch new file since the path is the same.
            self.localFileURL = localURL
        } else {
            /// File does not exist, download and cache it
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
        DispatchQueue.main.async {
            let totalDirectorySize = self.calculateTotalDirectorySize()
            print("DEBUG: Total directory size: \(totalDirectorySize) MB")
        }
    }

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
