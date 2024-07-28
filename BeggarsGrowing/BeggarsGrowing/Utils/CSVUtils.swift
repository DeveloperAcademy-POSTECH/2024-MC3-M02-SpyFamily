//
//  CSVUtils.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/26/24.
//

import Foundation
import SwiftData

struct CSVUtils {
//    static func saveFoodData(fooddata: inout [Food], modelContext: ModelContext) {
//        guard let url = Bundle.main.url(forResource: "Food", withExtension: "csv") else {
//            print("CSV file not found")
//            return
//        }
//        
//        do {
//            let data = try String(contentsOf: url)
//            let rows = data.components(separatedBy: "\n").dropFirst()
//            fooddata = rows.compactMap { row -> Food? in
//                let components = row.components(separatedBy: ",")
//                guard components.count >= 2 else { return nil }
//                
//                let image = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
//                let convertimage = String(image)
//                
//                let newData = Food(name: components[0], image: convertimage)
//                modelContext.insert(newData)
//                return newData
//            }
//        } catch {
//            print("Error reading CSV file:", error.localizedDescription)
//        }
//    }
//    
    static func saveRecipeData(fooddata: inout [Recipe], modelContext: ModelContext) {
        guard let url = Bundle.main.url(forResource: "Recipe", withExtension: "csv") else {
            print("CSV file not found")
            return
        }
        
        do {
            let data = try String(contentsOf: url)
            let rows = data.components(separatedBy: "\n").dropFirst()
            fooddata = rows.compactMap { row -> Recipe? in
                var components = row.components(separatedBy: ",")
                
                // 필요한 필드 수를 확인하고, 부족한 경우 빈 문자열로 채웁니다.
                while components.count < 7 {
                    components.append("")
                }
                
                let menu = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let link = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
                
                // foods와 foodsAmount를 배열로 변환
                let foods = components[2].trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: ",")
                let foodsAmount = components[3].trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: ",")
                
                let image = components[4].trimmingCharacters(in: .whitespacesAndNewlines)
                
                let sauce = components[5].trimmingCharacters(in: .whitespacesAndNewlines)
                let memo = components[6].trimmingCharacters(in: .whitespacesAndNewlines)
                
                let newData = Recipe(menu: menu, link: link, foods: foods, foodsAmount: foodsAmount, image:menu, sauce: sauce, memo: memo)
                modelContext.insert(newData)
                return newData
            }
        } catch {
            print("Error reading CSV file:", error.localizedDescription)
        }
    }
}
