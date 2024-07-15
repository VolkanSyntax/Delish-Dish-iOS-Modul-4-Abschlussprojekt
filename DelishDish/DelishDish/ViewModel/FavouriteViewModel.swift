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
    
    @Published var favoriteMeals: [Meal] = [] // Definiert eine veröffentlichte Variable für Lieblingsgerichte / Favori yemekler için yayımlanan bir değişken tanımlar
    
    private let firebaseAuth = Auth.auth() // Initialisiert die Firebase-Authentifizierung / Firebase kimlik doğrulamasını başlatır
    private let firebaseFirestore = Firestore.firestore() // Initialisiert die Firestore-Datenbank / Firestore veritabanını başlatır
    private var listener: ListenerRegistration? // Definiert eine Variable für den Listener / Dinleyici için bir değişken tanımlar
    
    func addMealToFavorites(meal: Meal) { // Definiert eine Funktion zum Hinzufügen eines Gerichts zu den Favoriten / Bir yemeği favorilere eklemek için bir fonksiyon tanımlar
        guard let userId = firebaseAuth.currentUser?.uid else { // Überprüft, ob der Benutzer eingeloggt ist / Kullanıcının oturum açıp açmadığını kontrol eder
            print("User not logged in") // Gibt eine Fehlermeldung aus / Bir hata mesajı yazdırır
            return // Beendet die Funktion / Fonksiyonu sonlandırır
        }
        
        let newFavoriteMeal = meal // Initialisiert eine neue Lieblingsmahlzeit / Yeni bir favori yemek başlatır
        
        do { // Versucht, die Lieblingsmahlzeit zu Firestore hinzuzufügen / Favori yemeği Firestore'a eklemeyi dener
            try firebaseFirestore.collection("users").document(userId).collection("favorites").document(meal.idMeal).setData(from: newFavoriteMeal) // Fügt die Lieblingsmahlzeit zur Firestore-Datenbank hinzu / Favori yemeği Firestore veritabanına ekler
            print("Meal added to favorites") // Gibt eine Erfolgsmeldung aus / Başarılı bir mesaj yazdırır
        } catch { // Fängt Speicherfehler ab / Kayıt hatalarını yakalar
            print("Error adding meal to favorites: \(error)") // Gibt eine Fehlermeldung aus / Bir hata mesajı yazdırır
        }
    }
    
    func fetchFavoriteMeals() { // Definiert eine Funktion zum Abrufen der Lieblingsgerichte / Favori yemekleri getiren bir fonksiyon tanımlar
        guard let userId = firebaseAuth.currentUser?.uid else { // Überprüft, ob der Benutzer eingeloggt ist / Kullanıcının oturum açıp açmadığını kontrol eder
            print("User not logged in") // Gibt eine Fehlermeldung aus / Bir hata mesajı yazdırır
            return // Beendet die Funktion / Fonksiyonu sonlandırır
        }
        
        self.listener = firebaseFirestore.collection("users").document(userId).collection("favorites") // Setzt den Listener für die Firestore-Sammlung / Firestore koleksiyonu için dinleyiciyi ayarlar
            .addSnapshotListener { snapshot, error in // Fügt einen Snapshot-Listener hinzu / Bir anlık görüntü dinleyicisi ekler
                if let error { // Überprüft auf Fehler / Hataları kontrol eder
                    print("Error fetching favorite meals: \(error)") // Gibt eine Fehlermeldung aus / Bir hata mesajı yazdırır
                    return // Beendet die Funktion / Fonksiyonu sonlandırır
                }
                
                guard let snapshot else { // Überprüft, ob der Snapshot vorhanden ist / Anlık görüntünün mevcut olup olmadığını kontrol eder
                    print("Snapshot is empty") // Gibt eine Fehlermeldung aus / Bir hata mesajı yazdırır
                    return // Beendet die Funktion / Fonksiyonu sonlandırır
                }
                
                let favoriteMeals = snapshot.documents.compactMap { document -> Meal? in // Mappt die Dokumente zu Meal-Objekten / Belgeleri Meal nesnelerine dönüştürür
                    do { // Versucht, das Dokument zu decodieren / Belgeyi çözmeyi dener
                        return try document.data(as: Meal.self) // Dekodiert das Dokument in ein Meal-Objekt / Belgeyi bir Meal nesnesine dönüştürür
                    } catch { // Fängt Decodierungsfehler ab / Çözümleme hatalarını yakalar
                        print("Error decoding meal: \(error)") // Gibt eine Fehlermeldung aus / Bir hata mesajı yazdırır
                    }
                    return nil // Gibt nil zurück, wenn die Decodierung fehlschlägt / Çözümleme başarısız olursa nil döndürür
                }
                
                self.favoriteMeals = favoriteMeals // Setzt die Lieblingsgerichte / Favori yemekleri ayarlar
            }
    }
    
    // Belirtilen ID'ye sahip yemeği favorilerden çıkarır.
    func removeMealFromFavorites(withId id: String?) { // Definiert eine Funktion zum Entfernen eines Gerichts aus den Favoriten anhand der ID / Belirtilen ID'ye sahip yemeği favorilerden çıkaran bir fonksiyon tanımlar
        guard let id else { // Überprüft, ob die ID vorhanden ist / ID'nin mevcut olup olmadığını kontrol eder
            print("Meal has no id!") // Gibt eine Fehlermeldung aus / Bir hata mesajı yazdırır
            return // Beendet die Funktion / Fonksiyonu sonlandırır
        }
        
        firebaseFirestore.collection("users").document(firebaseAuth.currentUser!.uid).collection("favorites").document(id).delete() { error in // Löscht das Dokument aus Firestore / Belgeyi Firestore'dan siler
            if let error { // Überprüft auf Fehler / Hataları kontrol eder
                print("Error removing meal from favorites: \(error)") // Gibt eine Fehlermeldung aus / Bir hata mesajı yazdırır
            }
        }
    }
}
