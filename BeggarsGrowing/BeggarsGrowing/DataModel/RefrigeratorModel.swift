//
//  RefrigeratorModel.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/23/24.
//

import SwiftUI
import SwiftData

@Model class Refrigerator {
    
    /// 냉장고 고유값
    @Attribute(.unique) var id: UUID = UUID()
    /// 재료
    var food: String
    /// 가격
    var price: Int
    /// 냉동 여부
    var freezing: Bool
    /// 현재 잔량
    var amount: Double
    /// 등록 날짜
    var date: Date
    
    init(food: String, price: Int, amount: Double, freezing: Bool, date: Date) {
        self.food = food
        self.price = price
        self.amount = amount
        self.freezing = freezing
        self.date = date
    }
}
