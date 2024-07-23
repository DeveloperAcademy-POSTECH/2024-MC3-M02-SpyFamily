//
//  BeggarsModel.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/23/24.
//

import SwiftUI
import SwiftData

@Model class Beggars {
    
    /// 거지 고유값
    @Attribute(.unique) var id: UUID = UUID()
    /// 거지명
    var name: String
    /// 이미지
    var image: Data
    /// 목표액
    var goalMoney: Int
    /// 현재 합계액
    var nowMoney: Int
    /// 클리어 날짜
    var clearDate: Date?
    
    init(name: String, image: Data, goalMoney:Int, nowMoney:Int) {
        self.name = name
        self.image = image
        self.goalMoney = goalMoney
        self.nowMoney = nowMoney
    }
}
