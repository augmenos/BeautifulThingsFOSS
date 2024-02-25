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
            if appModel.showLaunchScreen {
                LaunchView()
                    .environment(appModel)
                    .transition(.opacity)
                    .windowGeometryPreferences(resizingRestrictions: .none)
            } else {
                MainView()
                    .environment(appModel)
                    .opacity(appModel.showLaunchScreen ? 0 : 1)
                    .transition(.opacity)
                    .windowGeometryPreferences(resizingRestrictions: .none)
            }
        }
        .windowStyle(.plain)
        .defaultSize(width: 1075, height: 950)
        
        WindowGroup(id: "WebView") {
            ContentWebView()
                .environment(appModel)
        }
        .windowStyle(.plain)
        .defaultSize(width: 1100, height: 900)
        
        WindowGroup(id: "VolumeWindow") {
            ContentWebView()
        }
        .windowStyle(.volumetric)
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.progressive), in: .progressive)
    }
}
