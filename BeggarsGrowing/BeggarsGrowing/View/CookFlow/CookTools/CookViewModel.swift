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
    
    @Published var filteredRecipesBySelectedFoods: [Recipe] = []
    
    @Published var recentImage: UIImage?
    
    @Published var usedFoods: [(Refrigerator, Double)] = []
    @Published var foodsUsage: [(Refrigerator, Double)] = []
    
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
    
    func filterRecipeBySelectedFoods() {
        filteredRecipesBySelectedFoods.removeAll()
        for food in selectedFoods{
            for recipe in recommendedRecipeByRefri.filter{ $0.foods.contains(food.food)}{
                filteredRecipesBySelectedFoods.append(recipe)
            }
        }
        let forSetList = Set(filteredRecipesBySelectedFoods)
        filteredRecipesBySelectedFoods = Array(forSetList)
    }
    
    func finishCookRecord() -> History{
        let menu = selectedRecipe.menu
        let foods = usedFoods.map { $0.0.food }
//        let foodsUsage = usedFoods.map { ($0, (Double($0.0.amount) / Double(100)) * (Double($0.1) / Double(100))) }
//        let foodsPrice = foodsUsage.map { Int(Double($0.0.price) * (Double($0.0.amount) * ($0.1 / Double(100))) ) }
        let foodsUsage = usedFoods.map { food in
            let amountPercentage = Double(food.0.amount) / 100.0
            let usagePercentage = Double(food.1) / 100.0
            return (food.0, amountPercentage * usagePercentage)
        }
        self.foodsUsage = foodsUsage
        let foodsPrice = foodsUsage.map { foodUsage in
            let price = Double(foodUsage.0.price)
//            let amount = Double(foodUsage.0.amount)
            let usage = foodUsage.1
            return Int(price * usage)
        }
        let menuPrice = foodsPrice.reduce(0, +)
        var savedMoney = 0
        
        if 13000 - menuPrice > 0 {
            savedMoney = 13000 - menuPrice
        }
        
        
        let historyToAdd = History(menu: menu, foods: foods, foodsPrice: foodsPrice, menuPrice: foodsPrice.reduce(0, +), savedMoney: savedMoney, date: Date())
        print("history Success")
        return historyToAdd
    }
    
    func reset() {
        self.selectedFoods = []
        self.selectedRecipe = Recipe(menu: "", foods: [""], foodsAmount: [""])
        self.recentImage = nil
        self.usedFoods = []
    }
}
