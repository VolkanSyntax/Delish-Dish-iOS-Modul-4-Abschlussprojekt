//
//  RecipesDetailsView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 10.07.24.
//

import SwiftUI

struct RecipesDetailsView: View {
    
    let meal: Meal
    
    @EnvironmentObject var viewModel: RecipesListViewModel
    
    @State private var selectedTab: Tab = .ingredients
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                    image
                        .resizable()
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 300)
                .padding()
                
                HStack {
                    Spacer()
                    Button(action: {
                        // Favorite action
                    }) {
                        VStack {
                            Image(systemName: "heart")
                                .foregroundColor(.gray)
                            Text("Favourite")
                                .foregroundStyle(.gray)
                        }
                    }
                    Spacer()
                        .padding()
                    Button(action: {
                        // YouTube action
                    }) {
                        VStack {
                            Image(systemName: "video")
                                .foregroundColor(.gray)
                            Text("Youtube")
                                .foregroundStyle(.gray)
                        }
                    }
                    Spacer()
                }
                .padding(.vertical)
                
                HStack {
                    Text("NAME")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.horizontal)
                
                Text(meal.strMeal)
                    .font(.title)
                    .padding(.horizontal)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Category / Area")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(meal.strCategory)
                        Text(meal.strArea)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                Picker("Select", selection: $selectedTab) {
                    Text("Ingredient").tag(Tab.ingredients)
                    Text("Measure").tag(Tab.measures)
                    Text("Instructions").tag(Tab.instructions)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                
                switch selectedTab {
                
                case .ingredients:
                    Text(viewModel.ingredientsList(for: meal))
                        .padding(.horizontal)
                
                case .measures:
                    Text(viewModel.measuresList(for: meal))
                        .padding(.horizontal)
                
                case .instructions:
                    Text(meal.strInstructions)
                        .padding(.horizontal)
                }
            }
            .navigationTitle("Recipe Details")
        }
    }
    
    enum Tab {
        case ingredients, measures, instructions
    }
    
}

#Preview {
    RecipesListView()
        .environmentObject(RecipesListViewModel())
}

