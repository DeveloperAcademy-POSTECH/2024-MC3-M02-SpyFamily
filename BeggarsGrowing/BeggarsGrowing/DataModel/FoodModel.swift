//
//  FoodModel.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/23/24.
//

import SwiftUI
import SwiftData

@Model class Food {
    
    /// 재료 고유값
    @Attribute(.unique) var id: UUID = UUID()
    /// 재료명
    var name: String
    /// 이미지
    var image: Data

    init(name: String, image: Data) {
        self.name = name
        self.image = image
    }
}
