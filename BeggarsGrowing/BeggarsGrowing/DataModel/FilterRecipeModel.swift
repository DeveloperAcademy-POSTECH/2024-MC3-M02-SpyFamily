//
//  FilterRecipeModel.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/30/24.
//

import SwiftData
import SwiftUI

@Model
class FilterRecipe {
    
    /// 레시피 고유값
    @Attribute(.unique) var id: UUID = UUID()
    /// 요리명
    var food: String
    /// 
    var recipes: Set<UUID> = []
    
    init(id: UUID = UUID(), food: String, recipes: Set<UUID>) {
        self.id = id
        self.food = food
        self.recipes = recipes
    }
}
