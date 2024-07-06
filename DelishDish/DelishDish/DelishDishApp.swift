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
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            AuthentificationView()
                .environmentObject(LoginViewModel())
        }
    }
}
