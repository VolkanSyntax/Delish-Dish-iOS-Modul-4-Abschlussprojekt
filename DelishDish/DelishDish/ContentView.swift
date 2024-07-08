//
//  ContentView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 02.07.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.17, green: 0.26, blue: 0.3), location: 0.14),
                    Gradient.Stop(color: Color(red: 0.07, green: 0.18, blue: 0.23), location: 0.41),
                ],
                startPoint: UnitPoint(x: 0, y: 0.01),
                endPoint: UnitPoint(x: 0.97, y: 1)
            )
            .frame(width: 393, height: 852)
            .edgesIgnoringSafeArea(.all)

                
            }
            .padding()
        }
        
    }

#Preview {
    ContentView()
        .environmentObject(LoginViewModel())
}
