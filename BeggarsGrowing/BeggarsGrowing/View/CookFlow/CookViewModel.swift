//
//  CookViewModel.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/30/24.
//

import SwiftUI
import SwiftData
import Foundation

class CookViewModel : ObservableObject {
    
    @Published var selectedFoods: [Refrigerator] = []
    @Published var selectedRecipe: Recipe = Recipe(menu: "", foods: [""], foodsAmount: [""])
    
    @Published var foodsInRefri: [Refrigerator] = []
    @Published var recipeData: [Recipe] = []
    @Published var recipeIdsforFilter: [FilterRecipe] = []
    
    @Published var filteredRecipeIDsByRefri: Set<UUID> = []
    @Published var recommendedRecipeByRefri: [Recipe] = []
    
    @Published var recentImage: UIImage?
    
    func checkRefriFoodsInRecipe() {
        filteredRecipeIDsByRefri.removeAll()
        
        for food in foodsInRefri {
            let matchingRecipes = recipeIdsforFilter
                .filter { $0.food == food.food }
                .flatMap { $0.recipes }
            filteredRecipeIDsByRefri.formUnion(matchingRecipes)
            print(matchingRecipes)
            
        }
        self.recommendedRecipeByRefri = recipeData.filter { filteredRecipeIDsByRefri.contains($0.id) }
        print(self.recommendedRecipeByRefri)
        print("filtered \(filteredRecipeIDsByRefri)")
    }
}
