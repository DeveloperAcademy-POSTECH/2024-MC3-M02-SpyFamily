//
//  RecipeViewModel.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 8/2/24.
//


import SwiftUI
import SwiftData

class RecipeViewModel : ObservableObject {

    @Published var selectedRecipeforDetail: Recipe = Recipe(menu: "", foods: [""], foodsAmount: [""])
    
}
