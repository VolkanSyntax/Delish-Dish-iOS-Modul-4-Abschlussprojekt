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
    
    func loadMeals() async throws -> [Meal] { // Definiert eine Funktion zum Laden von Mahlzeiten / Yemekleri yükleyen bir fonksiyon tanımlar
        guard let url = URL(string: "https://www.themealdb.com/api/json/v2/\(ApiKeys.theMealDb.rawValue)/search.php?s=") else { // Überprüft, ob die URL gültig ist / URL'nin geçerli olup olmadığını kontrol eder
            throw ApiError.invalidURL // Wirft einen Fehler, wenn die URL ungültig ist / URL geçersizse hata fırlatır
        }
        
        let (data, _) = try await URLSession.shared.data(from: url) // Führt eine Netzwerkanfrage durch und holt die Daten / Bir ağ isteği yapar ve verileri alır
        let mealList = try JSONDecoder().decode(MealList.self, from: data) // Dekodiert die erhaltenen Daten in ein MealList-Objekt / Alınan verileri bir MealList nesnesine dönüştürür
        
        return mealList.meals // Gibt die Liste der Mahlzeiten zurück / Yemek listesini döndürür
    }
    
    func searchMeals(keyword: String) async throws -> [Meal] {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v2/\(ApiKeys.theMealDb.rawValue)/search.php?s=\(keyword)") else {
            throw ApiError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealList = try JSONDecoder().decode(MealList.self, from: data)
        
        return mealList.meals
    }
    
}
