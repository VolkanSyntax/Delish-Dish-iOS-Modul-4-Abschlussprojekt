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
}
