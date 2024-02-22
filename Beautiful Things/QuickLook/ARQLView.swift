//
//  ARQLView.swift
//
//  Created by Miguel Garcia Gonzalez on 2/21/24.
//

import SwiftUI
import QuickLook

struct ARQuickLookView: UIViewControllerRepresentable {
    var fileURL: URL

    func makeUIViewController(context: Context) -> QLPreviewController {
        let previewController = QLPreviewController()
        previewController.dataSource = context.coordinator
        return previewController
    }

    func updateUIViewController(_ uiViewController: QLPreviewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, QLPreviewControllerDataSource {
        var parent: ARQuickLookView

        init(_ parent: ARQuickLookView) {
            self.parent = parent
        }

        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }

        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            return parent.fileURL as NSURL
        }
    }
}

/// To customize?
//        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
//            let previewItem = ARQuickLookPreviewItem(fileAt: parent.fileURL)
//            // Customize the ARQuickLookPreviewItem here
//            previewItem.allowsContentScaling = false // Disable content scaling
//            return previewItem
//        }

struct ARQLView: View {
    @State private var isPresentingARQuickLook = false

    var body: some View {
        Button("Show AR Quick Look") {
            isPresentingARQuickLook = true
        }
        .sheet(isPresented: $isPresentingARQuickLook) {
            ARQuickLookView(fileURL: Bundle.main.url(forResource: "robot_walk_idle", withExtension: "usdz")!)
        }
        .onAppear {
            isPresentingARQuickLook = true
        }
    }
}

