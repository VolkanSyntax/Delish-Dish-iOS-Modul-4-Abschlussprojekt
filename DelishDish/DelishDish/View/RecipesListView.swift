//
//  RecipesListView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 10.07.24.
//

import SwiftUI

struct RecipesListView: View {
    
    @StateObject private var viewModel = RecipesListViewModel()

    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                TextField("Search", text: $viewModel.keyword, onCommit: {
                    viewModel.searchMeals()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

                Button(action: {
                    viewModel.loadMeals()
                }) {
                    Text("Recipes Generator")
                        .padding()
                        .frame(width: 175, height: 45)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding(.horizontal)
                
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.meals) { meal in
                        NavigationLink(destination: RecipesDetailsView(meal: meal)) {
                            HStack {
                                AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                } placeholder: {
                                    ProgressView()
                                }
                                VStack(alignment: .leading) {
                                    Text(meal.strMeal)
                                        .font(.headline)
                                    Text(meal.strCategory)
                                        .font(.subheadline)
                                }
                                .padding(.leading, 10)
                            }
                        }
                    }
                }
            }
            .navigationTitle("RecipeList")
            .onAppear {
                viewModel.loadMeals()
            }
        }
    }
}


#Preview {
    RecipesListView()
}
