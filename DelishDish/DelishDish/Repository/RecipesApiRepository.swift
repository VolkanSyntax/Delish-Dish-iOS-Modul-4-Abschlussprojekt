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
    // Definiert einen benutzerdefinierten Fehler für ungültige URLs.
    // Geçersiz URL'ler için özel bir hata tanımlar.
    func loadMeals() async throws -> [Meal] {
        // Definiert eine Funktion zum asynchronen Laden von Mahlzeiten.
        // Yemekleri asenkron olarak yüklemek için bir fonksiyon tanımlar.
        guard let url = URL(string: "https://www.themealdb.com/api/json/v2/\(ApiKeys.theMealDb.rawValue)/search.php?s=") else {
            // Überprüft, ob die URL gültig ist.
            // URL'nin geçerli olup olmadığını kontrol eder.
            throw ApiError.invalidURL
            // Wirft einen Fehler, wenn die URL ungültig ist.
            // URL geçersizse bir hata fırlatır.
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        // Führt eine Netzwerkanfrage durch und holt die Daten.
        // Bir ağ isteği yapar ve verileri alır.
        let mealList = try JSONDecoder().decode(MealList.self, from: data)
        // Dekodiert die erhaltenen Daten in ein MealList-Objekt.
        // Alınan verileri bir MealList nesnesine dönüştürür.
        return mealList.meals
        // Gibt die Liste der Mahlzeiten zurück.
        // Yemek listesini döndürür.
    }
    
    func searchMeals(keyword: String) async throws -> [Meal] {
        // Definiert eine Funktion zum asynchronen Suchen nach Mahlzeiten basierend auf einem Schlüsselwort.
        // Belirli bir anahtar kelimeye göre yemekleri asenkron olarak aramak için bir fonksiyon tanımlar.
        guard let url = URL(string: "https://www.themealdb.com/api/json/v2/\(ApiKeys.theMealDb.rawValue)/search.php?s=\(keyword)") else {
            // Überprüft, ob die URL mit dem Schlüsselwort gültig ist.
            // Anahtar kelime ile oluşturulan URL'nin geçerli olup olmadığını kontrol eder.
            throw ApiError.invalidURL
            // Wirft einen Fehler, wenn die URL ungültig ist.
            // URL geçersizse bir hata fırlatır.
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        // Führt eine Netzwerkanfrage mit dem Schlüsselwort durch und holt die Daten.
        // Anahtar kelime ile bir ağ isteği yapar ve verileri alır.
        let mealList = try JSONDecoder().decode(MealList.self, from: data)
        // Dekodiert die erhaltenen Daten in ein MealList-Objekt.
        // Alınan verileri bir MealList nesnesine dönüştürür.
        return mealList.meals
        // Gibt die Liste der nach dem Schlüsselwort gefilterten Mahlzeiten zurück.
        // Anahtar kelime ile filtrelenmiş yemek listesini döndürür.
    }
    
}

