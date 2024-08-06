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
        Food(name: "돼지고기", imageName: "Pork"),
        Food(name: "당근", imageName: "Carrot"),
        Food(name: "계란", imageName: "Egg"),
        Food(name: "양파", imageName: "Onion"),
        Food(name: "대파", imageName: "GreenOnion"),
        Food(name: "감자", imageName: "Potato"),
        Food(name: "마늘", imageName: "Garlic"),
        Food(name: "김치", imageName: "Kimchi"),
        Food(name: "소고기", imageName: "Beef"),
        Food(name: "닭고기", imageName: "Chicken"),
        Food(name: "생선", imageName: "Fish"),
        Food(name: "청양고추", imageName: "Pepper"),
        Food(name: "두부", imageName: "Tofu"),
        Food(name: "치즈", imageName: "Cheese"),
        Food(name: "콩나물", imageName: "BeanSprouts"),
        Food(name: "소시지", imageName: "Sausage"),
        Food(name: "새우", imageName: "Shrimp"),
        Food(name: "어묵", imageName: "FishCake"),
        Food(name: "우유", imageName: "Milk"),
        Food(name: "버섯", imageName: "Mushroom"),
        Food(name: "양배추", imageName: "Cabbage"),
        Food(name: "오이", imageName: "Cucumber"),
        Food(name: "애호박", imageName: "Squash"),
        Food(name: "깻잎", imageName: "Sesame"),
        Food(name: "오징어", imageName: "Squid")
    ]
    
    // 특정 이름에 대한 이미지를 반환하는 메서드
    func getImageName(for name: String) -> String? {
        if let ingredient = ingredients.first(where: { $0.name == name }) {
            return ingredient.imageName
        }
        return nil
    }
}
