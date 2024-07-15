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
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
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
