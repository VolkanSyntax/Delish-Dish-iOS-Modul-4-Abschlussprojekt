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
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
