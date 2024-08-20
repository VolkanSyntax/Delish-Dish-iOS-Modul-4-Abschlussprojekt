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
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Divider()
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
                .searchable(text: $viewModel.keyword, prompt: "search")
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
            .navigationTitle("list_of_recipes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSettings = true
                    }) {
                        VStack {
                            Image(systemName: "person.crop.circle")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                            Text("profile")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        
                    }
                }
            }
            .navigationDestination(isPresented: $showSettings) {
                ProfileView()
                    .environmentObject(LoginViewModel())
            }
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




