//
//  RecipesListView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 10.07.24.
//

import SwiftUI

struct RecipesListView: View {
    
    @StateObject private var viewModel = RecipesListViewModel()
    @State private var isSearching = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
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
                }
                
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
                .searchable(text: $viewModel.keyword, prompt: "Search")
                .autocorrectionDisabled(true)
                .onSubmit(of: .search) {
                    viewModel.searchMeals()
                    isSearching = true
                }
                .onChange(of: viewModel.keyword) {
                    if viewModel.keyword.isEmpty && isSearching {
                        viewModel.loadMeals()
                        viewModel.error = nil
                        isSearching = false
                    }
                }

                Spacer()
            }
            .navigationTitle("Recipe List")
            .onAppear {
                viewModel.loadMeals()
            }
        }
    }
}

#Preview {
    RecipesListView()
        .environmentObject(FavouriteViewModel())
}




