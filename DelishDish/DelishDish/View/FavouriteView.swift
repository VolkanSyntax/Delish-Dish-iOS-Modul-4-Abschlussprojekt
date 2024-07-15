//
//  FavouriteView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 10.07.24.
//

import SwiftUI

struct FavouriteView: View {
    
    @EnvironmentObject var favouriteViewModel: FavouriteViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(favouriteViewModel.favoriteMeals) { meal in
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
                            Spacer()
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let meal = favouriteViewModel.favoriteMeals[index]
                        favouriteViewModel.removeMealFromFavorites(withId: meal.idMeal)
                    }
                }
            }
            .navigationTitle("My Favourites")
            .onAppear {
                favouriteViewModel.fetchFavoriteMeals()
            }
        }
    }
}

#Preview {
    FavouriteView()
        .environmentObject(FavouriteViewModel())
}
