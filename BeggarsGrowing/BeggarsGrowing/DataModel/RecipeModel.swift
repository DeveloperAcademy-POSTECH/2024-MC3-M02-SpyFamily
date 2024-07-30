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
    var foods: [String]
    /// 필요 재료들
    var foodsAmount: [String]
    /// 레시피 이미지 - 유저 추가 시에는, image 이름을 UUID 로 설정
    var image: String?
    /// 기타 소스
    var sauce: String?
    /// 메모
    var memo: String?
    
    init(menu: String, link: String? = nil, foods: [String], foodsAmount: [String], image: String? = nil, sauce: String? = nil, memo: String? = nil) {
            self.menu = menu
            self.link = link
            self.foods = foods
            self.foodsAmount = foodsAmount
            self.image = image
            self.sauce = sauce
            self.memo = memo
        }
}
