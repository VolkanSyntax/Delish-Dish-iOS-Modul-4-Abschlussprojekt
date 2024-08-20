//
//  MarketAngebotenListView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 20.08.24.
//

import SwiftUI
import WebKit

struct MarketAngebotenListView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        MarketView(market: .kaufland)
                        MarketView(market: .lidl)
                    }
                    HStack {
                        MarketView(market: .aldi)
                        MarketView(market: .rewe)
                    }
                    HStack {
                        MarketView(market: .edeka)
                        MarketView(market: .netto)
                    }
                    HStack {
                        MarketView(market: .penny)
                        MarketView(market: .norma)
                    }
                }
                .padding()
            }
            .navigationBarTitle("Market")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MarketView: View {
    var market: Market
    
    var body: some View {
        VStack {
            NavigationLink(destination: MarketWebView(viewModel: MarketWebViewModel(urlString: market.url))) {
                Image("\(market.rawValue)-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 2)
                    )
            }
            
            Text(market.rawValue)
                .font(.headline)
                .foregroundColor(.black)
        }
        .padding()
    }
}

#Preview {
    MarketAngebotenListView()
}
