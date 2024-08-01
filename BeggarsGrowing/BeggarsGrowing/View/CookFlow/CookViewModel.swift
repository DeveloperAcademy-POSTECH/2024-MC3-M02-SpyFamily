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
    
    @Published var usedFoods: [(Refrigerator, Int)] = []
    
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
    
    func finishCookRecord() -> History{
        let menu = selectedRecipe.menu
        let foods = usedFoods.map { $0.0.food }
        let foodsPrice = usedFoods.map { Int(Double($0.0.price) * (Double($0.1) / Double(100))) }
        let menuPrice = foodsPrice.reduce(0, +)
        let savedMoney = 15000 - menuPrice
        
        let historyToAdd = History(menu: menu, foods: foods, foodsPrice: foodsPrice, menuPrice: foodsPrice.reduce(0, +), savedMoney: savedMoney, date: Date())
        print("history Success")
        return historyToAdd
    }
}
