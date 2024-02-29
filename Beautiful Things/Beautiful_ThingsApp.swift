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
                    ZStack {
                        MainView()
                            .environment(appModel)
                            .opacity(appModel.showLaunchScreen ? 0 : 1)
                            .animation(.easeInOut(duration: 2.0).delay(1.0), value: appModel.showLaunchScreen) // Delay the appearance of MainView
                            .windowGeometryPreferences(resizingRestrictions: .none)

                        if appModel.showLaunchScreen {
                            LaunchView()
                                .environment(appModel)
                                .transition(.opacity)
                                .windowGeometryPreferences(resizingRestrictions: .none)
                        }
                    }
                }
                .windowStyle(.plain)
                .defaultSize(width: 1300, height: 950)
    }
    
//    WindowGroup {
//        if appModel.showLaunchScreen {
//            LaunchView()
//                .environment(appModel)
//                .transition(.opacity)
//                .windowGeometryPreferences(resizingRestrictions: .none)
//        } else {
//            MainView()
//                .environment(appModel)
//                .opacity(appModel.showLaunchScreen ? 0 : 1)
//                .transition(.opacity)
//                .windowGeometryPreferences(resizingRestrictions: .none)
//        }
//    }
//    .windowStyle(.plain)
//    .defaultSize(width: 1300, height: 950)
    
}
