//
//  TestView.swift
//  Beautiful Things
//
//  Created by Miguel Garcia Gonzalez on 2/21/24.
//

import SwiftUI
import WebKit

struct WebViewV2: UIViewRepresentable {
    let html: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(html, baseURL: nil)
    }
}

struct TestView: View {
    var body: some View {
        VStack {
            Button("Load AR Object") {
                // Your HTML code
                let html = """
                <div>
                    <a rel="ar" href="https://storage.googleapis.com/beautiful-things-main/Things-USDZ/models/La_Luna.usdz" target="_blank">
                        <img src="https://storage.googleapis.com/beautiful-things-main/Things-USDZ/thumbnails/La_Luna.png" style="width: 300px; height: 300px;">
                    </a>
                </div>
                """
                // Present the WebView with the HTML code
                let webView = WebViewV2(html: html)
                let viewController = UIHostingController(rootView: webView)
                UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true)
            }
        }
    }
}
