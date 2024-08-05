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
    
    private let firebaseAuth = Auth.auth()
    private let firebaseFirestore = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    func addMealToFavorites(meal: Meal) {
        guard let userId = firebaseAuth.currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        let newFavoriteMeal = meal
        
        do {
            try firebaseFirestore.collection("users").document(userId).collection("favorites").document(meal.idMeal).setData(from: newFavoriteMeal)
            print("Meal added to favorites")
        } catch {
            print("Error adding meal to favorites: \(error)")
        }
    }
    
    func fetchFavoriteMeals() {
        guard let userId = firebaseAuth.currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        self.listener = firebaseFirestore.collection("users").document(userId).collection("favorites")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching favorite meals: \(error)")
                    return
                }

                guard let snapshot = snapshot else {
                    print("Snapshot is empty")
                    return
                }
                
                let favoriteMeals = snapshot.documents.compactMap { document -> Meal? in
                    do {
                        return try document.data(as: Meal.self)
                    } catch {
                        print("Error decoding meal: \(error)")
                    }
                    return nil
                }
                
                self.favoriteMeals = favoriteMeals
            }
    }
    
    func removeMealFromFavorites(withId id: String?) {
        guard let id = id else {
            print("Meal has no id!")
            return
        }
        
        guard let userId = firebaseAuth.currentUser?.uid else {
            print("User not logged in")
            return
        }

        firebaseFirestore.collection("users").document(userId).collection("favorites").document(id).delete() { error in
            if let error {
                print("Error removing meal from favorites: \(error)")
            }
        }
    }
}
