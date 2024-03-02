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
    @State private var showMainView = false

    var body: some Scene {
        WindowGroup {
            if !showMainView {
                LaunchView(showMainView: $showMainView)
                    .transition(.opacity)
            }

            if showMainView {
                MainView()
                    .transition(.opacity)
            }
        }
        .environment(appModel) // Provide the appModel to all views within the group
        .windowStyle(.plain)
        .defaultSize(width: 1300, height: 950)
    }
}
