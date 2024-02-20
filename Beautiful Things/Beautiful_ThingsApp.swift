//
//  Beautiful_ThingsApp.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import SwiftUI

@main
struct Beautiful_ThingsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.progressive), in: .progressive)
    }
}
