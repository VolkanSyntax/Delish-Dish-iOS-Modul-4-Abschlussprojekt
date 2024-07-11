//
//  RecipesViewModel.swift
//  DelishDish
//
//  Created by Volkan Yücel on 10.07.24.
//

import Foundation

class RecipesListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var isLoading = false
    @Published var keyword: String = ""
    @Published var error: String?

    private let repository = RecipesApiRepository()

    @MainActor
    func loadMeals() {
        isLoading = true
        error = nil
        Task {
            do {
                let meals = try await repository.loadMeals()
                self.meals = meals
                self.isLoading = false
            } catch {
                self.error = "Loading meals failed. Please check your network connection."
                self.isLoading = false
            }
        }
    }

    @MainActor
    func searchMeals() {
        isLoading = true
        error = nil
        Task {
            do {
                let meals = try await repository.searchMeals(keyword: keyword)
                self.meals = meals
                self.isLoading = false
            } catch {
                self.error = "Searching meals failed. Please check your network connection."
                self.isLoading = false
            }
        }
    }

    
    func ingredientsList(for meal: Meal) -> String {
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
        if let ingredient9 = meal.strIngredient9, !ingredient9.isEmpty {
            ingredients.append(ingredient9)
        }
        if let ingredient10 = meal.strIngredient10, !ingredient10.isEmpty {
            ingredients.append(ingredient10)
        }
        if let ingredient11 = meal.strIngredient11, !ingredient11.isEmpty {
            ingredients.append(ingredient11)
        }
        if let ingredient12 = meal.strIngredient12, !ingredient12.isEmpty {
            ingredients.append(ingredient12)
        }
        if let ingredient13 = meal.strIngredient13, !ingredient13.isEmpty {
            ingredients.append(ingredient13)
        }
        if let ingredient14 = meal.strIngredient14, !ingredient14.isEmpty {
            ingredients.append(ingredient14)
        }
        if let ingredient15 = meal.strIngredient15, !ingredient15.isEmpty {
            ingredients.append(ingredient15)
        }
        if let ingredient16 = meal.strIngredient16, !ingredient16.isEmpty {
            ingredients.append(ingredient16)
        }
        if let ingredient17 = meal.strIngredient17, !ingredient17.isEmpty {
            ingredients.append(ingredient17)
        }
        if let ingredient18 = meal.strIngredient18, !ingredient18.isEmpty {
            ingredients.append(ingredient18)
        }
        if let ingredient19 = meal.strIngredient19, !ingredient19.isEmpty {
            ingredients.append(ingredient19)
        }
        if let ingredient20 = meal.strIngredient20, !ingredient20.isEmpty {
            ingredients.append(ingredient20)
        }
        return ingredients.joined(separator: "\n")
    }

    func measuresList(for meal: Meal) -> String {
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
        if let measure9 = meal.strMeasure9, !measure9.isEmpty {
            measures.append(measure9)
        }
        if let measure10 = meal.strMeasure10, !measure10.isEmpty {
            measures.append(measure10)
        }
        if let measure11 = meal.strMeasure11, !measure11.isEmpty {
            measures.append(measure11)
        }
        if let measure12 = meal.strMeasure12, !measure12.isEmpty {
            measures.append(measure12)
        }
        if let measure13 = meal.strMeasure13, !measure13.isEmpty {
            measures.append(measure13)
        }
        if let measure14 = meal.strMeasure14, !measure14.isEmpty {
            measures.append(measure14)
        }
        if let measure15 = meal.strMeasure15, !measure15.isEmpty {
            measures.append(measure15)
        }
        if let measure16 = meal.strMeasure16, !measure16.isEmpty {
            measures.append(measure16)
        }
        if let measure17 = meal.strMeasure17, !measure17.isEmpty {
            measures.append(measure17)
        }
        if let measure18 = meal.strMeasure18, !measure18.isEmpty {
            measures.append(measure18)
        }
        if let measure19 = meal.strMeasure19, !measure19.isEmpty {
            measures.append(measure19)
        }
        if let measure20 = meal.strMeasure20, !measure20.isEmpty {
            measures.append(measure20)
        }
        
        return measures.joined(separator: "\n")
    }
}
