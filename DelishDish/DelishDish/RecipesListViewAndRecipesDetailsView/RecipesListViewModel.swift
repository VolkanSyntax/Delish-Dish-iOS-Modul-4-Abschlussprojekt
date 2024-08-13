//
//  RecipesViewModel.swift
//  DelishDish
//
//  Created by Volkan Yücel on 10.07.24.
//

import Foundation

class RecipesListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    // Eine Liste der Rezepte, die in der Benutzeroberfläche angezeigt werden sollen.
    // Kullanıcı arayüzünde gösterilecek yemek tariflerinin bir listesi.
    @Published var isLoading = false
    // Ein Boolescher Wert, der angibt, ob die Daten gerade geladen werden.
    // Verilerin şu anda yüklenip yüklenmediğini belirten bir Boolean değeri.
    @Published var keyword: String = ""
    // Das Schlüsselwort, nach dem in den Rezepten gesucht werden soll.
    // Tariflerde arama yapmak için kullanılacak anahtar kelime.
    @Published var error: String?
    // Eine optionale Zeichenkette, die eine Fehlermeldung enthält, falls das Laden oder die Suche fehlschlägt.
    // Yükleme veya arama başarısız olursa hata mesajını içeren isteğe bağlı bir metin.
    private let repository = RecipesApiRepository()
    // Ein Repository, das die API-Interaktionen für das Laden und Suchen von Rezepten verwaltet.
    // Tarifleri yüklemek ve aramak için API etkileşimlerini yöneten bir repository.
    @MainActor
    func loadMeals() {
        isLoading = true
        // Setzt den isLoading-Wert auf true, um anzuzeigen, dass die Rezepte geladen werden.
        // Tariflerin yüklendiğini belirtmek için isLoading değerini true olarak ayarlar.
        error = nil
        // Setzt die Fehlernachricht auf nil, um vorherige Fehler zu löschen.
        // Önceki hataları temizlemek için hata mesajını nil olarak ayarlar.
        Task {
            do {
                let meals = try await repository.loadMeals()
                self.meals = meals
                // Lädt die Rezepte aus dem Repository und aktualisiert die meals-Liste.
                // Tarifleri repository'den yükler ve meals listesini günceller.
                self.isLoading = false
                // Setzt isLoading auf false, nachdem das Laden abgeschlossen ist.
                // Yükleme tamamlandıktan sonra isLoading değerini false olarak ayarlar.
            } catch {
                self.error = "Loading meals failed. Please check your network connection."
                // Wenn ein Fehler auftritt, wird eine Fehlermeldung gesetzt.
                // Bir hata oluşursa hata mesajı ayarlanır.
                self.isLoading = false
                // Setzt isLoading auf false, auch wenn das Laden fehlschlägt.
                // Yükleme başarısız olsa bile isLoading değerini false olarak ayarlar.
            }
        }
    }
    
    @MainActor
    func searchMeals() {
        isLoading = true
        // Setzt den isLoading-Wert auf true, um anzuzeigen, dass die Suche durchgeführt wird.
        // Aramanın yapıldığını belirtmek için isLoading değerini true olarak ayarlar.
        error = nil
        // Setzt die Fehlernachricht auf nil, um vorherige Fehler zu löschen.
        // Önceki hataları temizlemek için hata mesajını nil olarak ayarlar.
        
        Task {
            do {
                let meals = try await repository.searchMeals(keyword: keyword)
                self.meals = meals
                // Sucht nach Rezepten im Repository basierend auf dem Schlüsselwort und aktualisiert die meals-Liste.
                // Anahtar kelimeye göre repository'de tarifleri arar ve meals listesini günceller.
                
                self.isLoading = false
                // Setzt isLoading auf false, nachdem die Suche abgeschlossen ist.
                // Arama tamamlandıktan sonra isLoading değerini false olarak ayarlar.
            } catch {
                self.error = "Searching meals failed. Please check your network connection."
                // Wenn ein Fehler bei der Suche auftritt, wird eine Fehlermeldung gesetzt.
                // Arama sırasında bir hata oluşursa hata mesajı ayarlanır.
                
                self.isLoading = false
                // Setzt isLoading auf false, auch wenn die Suche fehlschlägt.
                // Arama başarısız olsa bile isLoading değerini false olarak ayarlar.
            }
        }
    }
}

