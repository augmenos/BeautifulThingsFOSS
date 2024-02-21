//
//  WebView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/21/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var htmlContent: String
    var navigationDelegate = WebViewNavigationDelegate()
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = navigationDelegate
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: URL(string: "https://example.com"))
    }
}

class WebViewNavigationDelegate: NSObject, WKNavigationDelegate {
    @Environment(\.openWindow) private var openWindow

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, navigationAction.navigationType == .linkActivated {
            // Handle the URL navigation here, e.g., open it in a new window or perform a custom action
            openWindow(id: "VolumeWindow")
            print("Link clicked: \(url)")
            
            // Instead of directly opening the URL, you might need to use visionOS-specific APIs to handle the navigation
            // For example, you might need to convert the URL to a 3D object or use a specific method to open it in the 3D environment
            
            decisionHandler(.cancel) // Prevent the WebView from navigating
        } else {
            decisionHandler(.allow)
        }
    }
}

struct ContentWebView: View {
    
    var body: some View {
        WebView(htmlContent: """
        <div>
            <a rel="ar" href="https://storage.googleapis.com/beautiful-things-main/Things-USDZ/models/La_Luna.usdz"  target="_blank">
        <img src="https://storage.googleapis.com/beautiful-things-main/Things-USDZ/thumbnails/La_Luna.png" style="width: 300px; height: 300px;">
        </a>
        </div>
        """)
    }
}
