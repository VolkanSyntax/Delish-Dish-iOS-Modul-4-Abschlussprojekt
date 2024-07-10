//
//  ContentView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 02.07.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
            TabView {
                RecipesListView()
                    .tabItem { Label("Recipe", systemImage: "book.pages") }
                
                FavouriteView()
                    .tabItem { Label("Favourite", systemImage: "heart") }
                
                ToDoView()
                    .tabItem { Label("ToDo", systemImage: "list.clipboard") }
                
                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gear") }
            }
            
        }
    }

#Preview {
    ContentView()
        .environmentObject(LoginViewModel())
}
