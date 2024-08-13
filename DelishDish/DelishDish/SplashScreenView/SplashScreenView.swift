//
//  SplashScreenView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 12.08.24.
//

import SwiftUI

struct SplashScreenView: View {
    
    @StateObject private var viewModel = SplashScreenViewModel()

    var body: some View {
        ZStack {
            if viewModel.isActive {
                Color.clear
                    .background(
                        Color.white
                    )
                    .edgesIgnoringSafeArea(.all)
            } else {
                VStack {
                    VStack {
                        Image("Splash-logo")
                        Text("Delish-Dish")
                            .font(Font.custom("Krona One", size: 36))
                            .frame(width: 200, height: 35)
                    }
                    .scaleEffect(viewModel.size)
                    .opacity(viewModel.opacity)
                    .onAppear {
                        viewModel.onAppear()
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
