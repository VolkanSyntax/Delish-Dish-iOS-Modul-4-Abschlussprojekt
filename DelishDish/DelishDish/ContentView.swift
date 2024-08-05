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
                .tabItem { Label("Recipe", systemImage: "book.pages") }
                .tag(0)
                .background(Color.green.opacity(4.1))
            
            FavouriteView()
                .tabItem { Label("Favourite", systemImage: "heart") }
                .tag(1)
            
            ToDoListView()
                .tabItem { Label("ToDo", systemImage: "list.clipboard") }
                .tag(2)
            
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
                .tag(3)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FavouriteViewModel())
        .environmentObject(LoginViewModel())
}

