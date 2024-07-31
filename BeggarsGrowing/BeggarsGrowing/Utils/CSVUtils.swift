//
//  CSVUtils.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/26/24.
//

import Foundation
import SwiftData

struct CSVUtils {
    static func saveRecipeData(fooddata: inout [Recipe], modelContext: ModelContext) {
        guard let url = Bundle.main.url(forResource: "Recipe", withExtension: "csv") else {
            print("CSV file not found")
            return
        }
        
        do {
            var dictionaryForFilterRecipe: [String: Set<UUID>] = [:]
            for food in FoodImageName().ingredients{
                dictionaryForFilterRecipe[food.name] = []
            }
            
            let data = try String(contentsOf: url)
            let rows = data.components(separatedBy: "\n").dropFirst()
            fooddata = rows.compactMap { row -> Recipe? in
                var components = splitCSVRow(row)
                
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
                
                let newData = Recipe(menu: menu, link: link, foods: foods, foodsAmount: foodsAmount, image:image, sauce: sauce, memo: String(memo))
                
                for food in foods{
                    dictionaryForFilterRecipe[food]?.insert(newData.id)
                    print(food)
                }
                
                modelContext.insert(newData)
                
                return newData
            }
            for filterRecipe in dictionaryForFilterRecipe{
                let filterData = FilterRecipe(food: filterRecipe.key, recipes: filterRecipe.value)
                print(filterData.recipes.count)
                print(filterRecipe.value.map {$0.uuidString}.joined(separator: "\n"))
                modelContext.insert(filterData)
                print("filterData complete")
            }
        } catch {
            print("Error reading CSV file:", error.localizedDescription)
        }
    }
}

func splitCSVRow(_ row: String) -> [String] {
    var result: [String] = []
    var current = ""
    var insideQuotes = false

    for character in row {
        switch character {
        case "\"":
            insideQuotes.toggle()
        case ",":
            if insideQuotes {
                current.append(character)
            } else {
                result.append(current)
                current = ""
            }
        default:
            current.append(character)
        }
    }
    result.append(current)
    return result
}
