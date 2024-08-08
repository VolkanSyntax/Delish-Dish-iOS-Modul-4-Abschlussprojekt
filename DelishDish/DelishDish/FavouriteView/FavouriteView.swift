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
                ForEach(favouriteViewModel.favoriteMeals, id: \.idMeal) { meal in
                    NavigationLink(destination: RecipesDetailsView(meal: meal)) {
                        HStack {
                            AsyncImage(url: URL(string: meal.strMealThumb)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                } else if phase.error != nil {
                                    Color.red.frame(width: 100, height: 100)
                                } else {
                                    ProgressView()
                                        .frame(width: 100, height: 100)
                                }
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
                                .font(.title)
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
            .navigationBarTitleDisplayMode(.inline)
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


