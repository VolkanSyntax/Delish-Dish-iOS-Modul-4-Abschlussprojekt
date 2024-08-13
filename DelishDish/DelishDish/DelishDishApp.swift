//
//  DelishDishApp.swift
//  DelishDish
//
//  Created by Volkan Yücel on 02.07.24.
//


 import Firebase
 import FirebaseAuth
 import SwiftUI

 @main
 struct DelishDishApp: App {

     @StateObject private var loginViewModel = LoginViewModel()
     @StateObject private var favoriteViewModel = FavouriteViewModel()
     @State private var showSplash = true
     init() {
         FirebaseConfiguration.shared.setLoggerLevel(.min)
         FirebaseApp.configure()
     }

     var body: some Scene {
         WindowGroup {
             if showSplash {
                 SplashScreenView()
                     .onAppear {
                         DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                             withAnimation {
                                 self.showSplash = false
                             }
                         }
                     }
             } else {
                 if loginViewModel.isUserLoggeIn {
                     ContentView()
                         .environmentObject(loginViewModel)
                         .environmentObject(favoriteViewModel)
                 } else {
                     AuthentificationView()
                         .environmentObject(loginViewModel)
                 }
             }
         }
     }
 }
