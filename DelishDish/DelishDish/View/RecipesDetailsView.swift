//
//  RecipesDetailsView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 10.07.24.
//

import SwiftUI

struct RecipesDetailsView: View {
    
    let meal: Meal
    
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
                    Text(ingredientsList(meal))
                        .padding(.horizontal)
                case .measures:
                    Text(measuresList(meal))
                        .padding(.horizontal)
                case .instructions:
                    Text(meal.strInstructions)
                        .padding(.horizontal)
                }
            }
            .navigationTitle("Recipe Details")
        }
    }

    private func ingredientsList(_ meal: Meal) -> String {
        var ingredients = [String]()
        if let ingredient1 = meal.strIngredient1, !ingredient1.isEmpty {
            ingredients.append(ingredient1)
        }
        if let ingredient2 = meal.strIngredient2, !ingredient2.isEmpty {
            ingredients.append(ingredient2)
        }
        if let ingredient3 = meal.strIngredient3, !ingredient3.isEmpty {
            ingredients.append(ingredient3)
        }
        if let ingredient4 = meal.strIngredient4, !ingredient4.isEmpty {
            ingredients.append(ingredient4)
        }
        if let ingredient5 = meal.strIngredient5, !ingredient5.isEmpty {
            ingredients.append(ingredient5)
        }
        if let ingredient6 = meal.strIngredient6, !ingredient6.isEmpty {
            ingredients.append(ingredient6)
        }
        if let ingredient7 = meal.strIngredient7, !ingredient7.isEmpty {
            ingredients.append(ingredient7)
        }
        if let ingredient8 = meal.strIngredient8, !ingredient8.isEmpty {
            ingredients.append(ingredient8)
        }
        return ingredients.joined(separator: "\n")
    }

    private func measuresList(_ meal: Meal) -> String {
        var measures = [String]()
        if let measure1 = meal.strMeasure1, !measure1.isEmpty {
            measures.append(measure1)
        }
        if let measure2 = meal.strMeasure2, !measure2.isEmpty {
            measures.append(measure2)
        }
        if let measure3 = meal.strMeasure3, !measure3.isEmpty {
            measures.append(measure3)
        }
        if let measure4 = meal.strMeasure4, !measure4.isEmpty {
            measures.append(measure4)
        }
        if let measure5 = meal.strMeasure5, !measure5.isEmpty {
            measures.append(measure5)
        }
        if let measure6 = meal.strMeasure6, !measure6.isEmpty {
            measures.append(measure6)
        }
        if let measure7 = meal.strMeasure7, !measure7.isEmpty {
            measures.append(measure7)
        }
        if let measure8 = meal.strMeasure8, !measure8.isEmpty {
            measures.append(measure8)
        }
        return measures.joined(separator: "\n")
    }

    enum Tab {
        case ingredients, measures, instructions
    }
}

#Preview {
    RecipesListView()
}
