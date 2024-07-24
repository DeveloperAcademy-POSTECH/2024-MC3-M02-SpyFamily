//
//  History.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/23/24.
//

import SwiftUI
import SwiftData

@Model class History {
    
    /// 기록 고유값
    @Attribute(.unique) var id: UUID = UUID()
    /// 사용된 메뉴명
    var menu: String
    /// 사용된 재료들 : 재료명
    var foods: [Food]
    /// 사용된 재료들 : 양
    var foodsPrice: [Int]
    /// 음식값
    var foodPrice: Int
    /// 아껴진 돈
    var savedMoney: Int
    /// 촬영 이미지
    var image: Data?
    /// 날짜
    var date: Date
    
    init(menu: String, foods: [Food], foodsPrice: [Int], foodPrice: Int, savedMoney: Int, date: Date) {
        self.menu = menu
        self.foods = foods
        self.foodsPrice = foodsPrice
        self.foodPrice = foodPrice
        self.savedMoney = savedMoney
        self.date = date
    }
}
