//
//  MarketWebView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 20.08.24.
//

import SwiftUI

struct MarketWebView: View {
    @ObservedObject var viewModel: MarketWebViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.goBack()
                }) {
                    Image(systemName: "arrow.left")
                }
                Spacer()
                Button(action: {
                    viewModel.goHome()
                }) {
                    Image(systemName: "house")
                }
                Spacer()
                Button(action: {
                    viewModel.refresh()
                }) {
                    Image(systemName: "arrow.clockwise")
                }
                Spacer()
                Button(action: {
                    viewModel.goForward()
                }) {
                    Image(systemName: "arrow.right")
                }
            }
            .padding()
            WebView(viewModel: viewModel)
        }
    }
}

