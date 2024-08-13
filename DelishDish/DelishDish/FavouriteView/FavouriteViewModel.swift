//
//  FavouriteViewModel.swift
//  DelishDish
//
//  Created by Volkan Yücel on 12.07.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FavouriteViewModel: ObservableObject {
    
    @Published var favoriteMeals: [Meal] = []
    // Eine Liste der Lieblingsmahlzeiten, die in der Ansicht angezeigt werden soll.
    // Görünümde görüntülenecek favori yemeklerin bir listesini tutar.
    private let firebaseAuth = Auth.auth()
    // Eine Instanz von FirebaseAuth, um die Authentifizierung des Benutzers zu verwalten.
    // Kullanıcının kimlik doğrulamasını yönetmek için bir FirebaseAuth örneği.
    private let firebaseFirestore = Firestore.firestore()
    // Eine Instanz von Firestore, um auf die Datenbank zuzugreifen.
    // Veritabanına erişmek için bir Firestore örneği.
    private var listener: ListenerRegistration?
    // Ein Listener zum Überwachen von Änderungen in der Firestore-Datenbank.
    // Firestore veritabanındaki değişiklikleri izlemek için bir dinleyici.
    
    func addMealToFavorites(meal: Meal) {
        guard let userId = firebaseAuth.currentUser?.uid else {
            print("User not logged in")
            // Gibt eine Fehlermeldung aus, wenn der Benutzer nicht eingeloggt ist.
            // Kullanıcı giriş yapmamışsa bir hata mesajı yazdırır.
            return
        }
        
        let newFavoriteMeal = meal
        // Erstellt eine neue Lieblingsmahlzeit basierend auf der übergebenen Mahlzeit.
        // Geçilen yemeğe dayalı olarak yeni bir favori yemek oluşturur.
        
        do {
            try firebaseFirestore.collection("users").document(userId).collection("favorites").document(meal.idMeal).setData(from: newFavoriteMeal)
            print("Meal added to favorites")
            // Fügt die Mahlzeit zu den Favoriten des Benutzers in der Firestore-Datenbank hinzu.
            // Yemeği, kullanıcının Firestore veritabanındaki favorilerine ekler.
        } catch {
            print("Error adding meal to favorites: \(error)")
            // Gibt eine Fehlermeldung aus, wenn das Hinzufügen der Mahlzeit zu den Favoriten fehlschlägt.
            // Yemeği favorilere eklerken bir hata oluşursa bir hata mesajı yazdırır.
        }
    }
    
    func fetchFavoriteMeals() {
        guard let userId = firebaseAuth.currentUser?.uid else {
            print("User not logged in")
            // Gibt eine Fehlermeldung aus, wenn der Benutzer nicht eingeloggt ist.
            // Kullanıcı giriş yapmamışsa bir hata mesajı yazdırır.
            return
        }
        
        self.listener = firebaseFirestore.collection("users").document(userId).collection("favorites")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching favorite meals: \(error)")
                    // Gibt eine Fehlermeldung aus, wenn das Abrufen der Lieblingsmahlzeiten fehlschlägt.
                    // Favori yemekleri getirirken bir hata oluşursa bir hata mesajı yazdırır.
                    return
                }
                
                guard let snapshot = snapshot else {
                    print("Snapshot is empty")
                    // Gibt eine Fehlermeldung aus, wenn der Snapshot leer ist.
                    // Snapshot boşsa bir hata mesajı yazdırır.
                    return
                }
                
                let favoriteMeals = snapshot.documents.compactMap { document -> Meal? in
                    do {
                        return try document.data(as: Meal.self)
                        // Dekodiert jedes Dokument im Snapshot zu einem Meal-Objekt.
                        // Snapshot'taki her belgeyi bir Meal nesnesine dönüştürür.
                    } catch {
                        print("Error decoding meal: \(error)")
                        // Gibt eine Fehlermeldung aus, wenn das Dekodieren einer Mahlzeit fehlschlägt.
                        // Bir yemeği çözümlerken bir hata oluşursa bir hata mesajı yazdırır.
                    }
                    return nil
                }
                
                self.favoriteMeals = favoriteMeals
                // Aktualisiert die Liste der Lieblingsmahlzeiten basierend auf dem Abruf.
                // Getirilen verilere göre favori yemekler listesini günceller.
            }
    }
    
    func removeMealFromFavorites(withId id: String?) {
        guard let id = id else {
            print("Meal has no id!")
            // Gibt eine Fehlermeldung aus, wenn die Mahlzeit keine ID hat.
            // Yemeğin kimliği yoksa bir hata mesajı yazdırır.
            return
        }
        
        guard let userId = firebaseAuth.currentUser?.uid else {
            print("User not logged in")
            // Gibt eine Fehlermeldung aus, wenn der Benutzer nicht eingeloggt ist.
            // Kullanıcı giriş yapmamışsa bir hata mesajı yazdırır.
            return
        }
        
        firebaseFirestore.collection("users").document(userId).collection("favorites").document(id).delete() { error in
            if let error {
                print("Error removing meal from favorites: \(error)")
                // Gibt eine Fehlermeldung aus, wenn das Entfernen der Mahlzeit aus den Favoriten fehlschlägt.
                // Yemeği favorilerden kaldırırken bir hata oluşursa bir hata mesajı yazdırır.
            }
        }
    }
}

