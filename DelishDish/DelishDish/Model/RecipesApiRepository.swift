//
//  RecipesApiRepository.swift
//  DelishDish
//
//  Created by Volkan Yücel on 10.07.24.
//

import Foundation

class RecipesApiRepository {
    enum ApiError: Error {
        case invalidURL
    }

    func loadMeals() async throws -> [Meal] {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=") else {
            throw ApiError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let mealList = try JSONDecoder().decode(MealList.self, from: data)

        return mealList.meals
    }

    func searchMeals(keyword: String) async throws -> [Meal] {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(keyword)") else {
            throw ApiError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealList = try JSONDecoder().decode(MealList.self, from: data)
        return mealList.meals
    }
    
   /* func loadMealDetails(id: String) async throws -> Meal? {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
            throw ApiError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealList = try JSONDecoder().decode(MealList.self, from: data)
        return mealList.meals.first
    }
    
    */
}
