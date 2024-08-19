//
//  ContentView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 02.07.24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            RecipesListView()
                .tabItem { Label("recipes", systemImage: "book.pages") }
                .tag(0)

            FavouriteView()
                .tabItem { Label("favorites", systemImage: "heart") }
                .tag(1)
            
            RecipesAIView()
                .tabItem { Label ("recipeai", systemImage: "cpu") }
                .tag(2)
            
            ToDoListView()
                .tabItem { Label("ToDo", systemImage: "list.clipboard") }
                .tag(3)
            
            SettingsView()
                .tabItem { Label("setting", systemImage: "gear") }
                .tag(4)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FavouriteViewModel())
        .environmentObject(LoginViewModel())
}

