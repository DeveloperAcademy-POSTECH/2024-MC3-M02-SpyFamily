//
//  RecipeModel.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/23/24.
//

import SwiftUI
import SwiftData

@Model class Recipe {
    
    /// 레시피 고유값
    @Attribute(.unique) var id: UUID = UUID()
    /// 요리명
    var menu: String
    /// 링크
    var link: String?
    /// 필요 재료들 :
    var foods: [Food]
    /// 필요 재료들
    var foodsAmount: [String]
    /// 레시피 이미지
    var image: Data?
    /// 기타 소스
    var sauce: String?
    /// 메모
    var memo: String?
    
    init(menu: String, foods: [Food], foodsAmount: [String]) {
        self.menu = menu
        self.foods = foods
        self.foodsAmount = foodsAmount
    }
}
