//
//  Beautiful_ThingsApp.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import SwiftUI

@main
struct Beautiful_ThingsApp: App {
    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
        }
        .windowStyle(.plain)
        .defaultSize(width: 1100, height: 900)
        
        WindowGroup(id: "WebView") {
            ContentWebView()
                .environment(appModel)
        }
        .windowStyle(.plain)
        .defaultSize(width: 1100, height: 900)

        // VolumeWindow
        WindowGroup(id: "VolumeWindow") {
            ContentWebView()
        }
        .windowStyle(.volumetric)
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.progressive), in: .progressive)
    }
}
