//
//  FoodModel.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/23/24.
//

import SwiftUI

struct Food {
    let name: String
    let imageName: String
}

struct FoodImageName {
    // 고정된 데이터
    let ingredients: [Food] = [
        Food(name: "계란", imageName: "Egg"),
        Food(name: "사과", imageName: "Apple"),
        Food(name: "당근", imageName: "carrot"),
        Food(name: "돼지고기", imageName: "Pork")
    ]
    
    // 특정 이름에 대한 이미지를 반환하는 메서드
    func getImageName(for name: String) -> String? {
        if let ingredient = ingredients.first(where: { $0.name == name }) {
            return ingredient.imageName
        }
        return nil
    }
}
