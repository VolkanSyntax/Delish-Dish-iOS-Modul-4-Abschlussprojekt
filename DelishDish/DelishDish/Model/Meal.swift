//
//  Meal.swift
//  DelishDish
//
//  Created by Volkan Yücel on 10.07.24.
//

import Foundation
import FirebaseFirestoreSwift

struct MealList: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    
    var id: String {
        return idMeal
    }
    
    func ingredientsList() -> String {
        var ingredients = [String]()
        
        if let ingredient1 = strIngredient1, !ingredient1.isEmpty { ingredients.append(ingredient1) }
        if let ingredient2 = strIngredient2, !ingredient2.isEmpty { ingredients.append(ingredient2) }
        if let ingredient3 = strIngredient3, !ingredient3.isEmpty { ingredients.append(ingredient3) }
        if let ingredient4 = strIngredient4, !ingredient4.isEmpty { ingredients.append(ingredient4) }
        if let ingredient5 = strIngredient5, !ingredient5.isEmpty { ingredients.append(ingredient5) }
        if let ingredient6 = strIngredient6, !ingredient6.isEmpty { ingredients.append(ingredient6) }
        if let ingredient7 = strIngredient7, !ingredient7.isEmpty { ingredients.append(ingredient7) }
        if let ingredient8 = strIngredient8, !ingredient8.isEmpty { ingredients.append(ingredient8) }
        if let ingredient9 = strIngredient9, !ingredient9.isEmpty { ingredients.append(ingredient9) }
        if let ingredient10 = strIngredient10, !ingredient10.isEmpty { ingredients.append(ingredient10) }
        if let ingredient11 = strIngredient11, !ingredient11.isEmpty { ingredients.append(ingredient11) }
        if let ingredient12 = strIngredient12, !ingredient12.isEmpty { ingredients.append(ingredient12) }
        if let ingredient13 = strIngredient13, !ingredient13.isEmpty { ingredients.append(ingredient13) }
        if let ingredient14 = strIngredient14, !ingredient14.isEmpty { ingredients.append(ingredient14) }
        if let ingredient15 = strIngredient15, !ingredient15.isEmpty { ingredients.append(ingredient15) }
        if let ingredient16 = strIngredient16, !ingredient16.isEmpty { ingredients.append(ingredient16) }
        if let ingredient17 = strIngredient17, !ingredient17.isEmpty { ingredients.append(ingredient17) }
        if let ingredient18 = strIngredient18, !ingredient18.isEmpty { ingredients.append(ingredient18) }
        if let ingredient19 = strIngredient19, !ingredient19.isEmpty { ingredients.append(ingredient19) }
        if let ingredient20 = strIngredient20, !ingredient20.isEmpty { ingredients.append(ingredient20) }
        
        return ingredients.joined(separator: "\n")
    }
    
    func measuresList() -> String {
        var measures = [String]()
        
        if let measure1 = strMeasure1, !measure1.isEmpty { measures.append(measure1) }
        if let measure2 = strMeasure2, !measure2.isEmpty { measures.append(measure2) }
        if let measure3 = strMeasure3, !measure3.isEmpty { measures.append(measure3) }
        if let measure4 = strMeasure4, !measure4.isEmpty { measures.append(measure4) }
        if let measure5 = strMeasure5, !measure5.isEmpty { measures.append(measure5) }
        if let measure6 = strMeasure6, !measure6.isEmpty { measures.append(measure6) }
        if let measure7 = strMeasure7, !measure7.isEmpty { measures.append(measure7) }
        if let measure8 = strMeasure8, !measure8.isEmpty { measures.append(measure8) }
        if let measure9 = strMeasure9, !measure9.isEmpty { measures.append(measure9) }
        if let measure10 = strMeasure10, !measure10.isEmpty { measures.append(measure10) }
        if let measure11 = strMeasure11, !measure11.isEmpty { measures.append(measure11) }
        if let measure12 = strMeasure12, !measure12.isEmpty { measures.append(measure12) }
        if let measure13 = strMeasure13, !measure13.isEmpty { measures.append(measure13) }
        if let measure14 = strMeasure14, !measure14.isEmpty { measures.append(measure14) }
        if let measure15 = strMeasure15, !measure15.isEmpty { measures.append(measure15) }
        if let measure16 = strMeasure16, !measure16.isEmpty { measures.append(measure16) }
        if let measure17 = strMeasure17, !measure17.isEmpty { measures.append(measure17) }
        if let measure18 = strMeasure18, !measure18.isEmpty { measures.append(measure18) }
        if let measure19 = strMeasure19, !measure19.isEmpty { measures.append(measure19) }
        if let measure20 = strMeasure20, !measure20.isEmpty { measures.append(measure20) }
        
        return measures.joined(separator: "\n")
    }
}
