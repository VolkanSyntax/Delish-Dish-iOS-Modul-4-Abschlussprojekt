//
//  MarketWebViewModel.swift
//  DelishDish
//
//  Created by Volkan Yücel on 20.08.24.
//

import SwiftUI
import WebKit

class MarketWebViewModel: ObservableObject {
    @Published var urlString: String
    var webView: WKWebView
    private var initialURLString: String
    
    init(urlString: String) {
        self.urlString = urlString
        self.initialURLString = urlString
        self.webView = WKWebView()
        loadPage()
    }
    
    func goBack() {
        webView.goBack()
    }
    
    func goForward() {
        webView.goForward()
    }
    
    func refresh() {
        webView.reload()
    }
    
    func loadPage() {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func goHome() {
        if let url = URL(string: initialURLString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}


struct WebView: UIViewRepresentable {
    @ObservedObject var viewModel: MarketWebViewModel

    func makeUIView(context: Context) -> WKWebView {
        return viewModel.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: viewModel.urlString), uiView.url != url {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
