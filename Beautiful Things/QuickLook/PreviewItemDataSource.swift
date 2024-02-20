//
//  PreviewItemDataSource.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/20/24.
//

import SwiftUI
import QuickLook

class PreviewItemDataSource: NSObject, QLPreviewControllerDataSource {
    var previewItemURL: URL?

    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return previewItemURL != nil ? 1 : 0
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        guard let url = previewItemURL else {
            fatalError("Preview item URL not set")
        }
        return url as QLPreviewItem
    }
}
