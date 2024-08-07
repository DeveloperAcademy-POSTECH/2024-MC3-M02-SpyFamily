//
//  ContentView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var navigationManager = NavigationManager()
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true // CSV 불러왔는지 True, False로 UserDefaults 저장

    @Environment(\.modelContext) var modelContext
    
    @Query var foodsInRefri : [Refrigerator]
    @Query var recipeData : [Recipe]
    @Query var filterRecipes : [FilterRecipe]
    
    @EnvironmentObject var viewModel: CookViewModel
    
    @State private var recipeCSVData: [Recipe] = []
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            VStack {
                Text("여기는 실제로 보이지 않는 화면입니다.")
                Button("메인 화면으로") {
                    navigationManager.push(to: .main)
                }
            }
            .navigationDestination(for: PathType.self) { pathType in
                pathType.NavigatingView()
            }
        }
        .environment(navigationManager)
        .onAppear {
            DispatchQueue.main.async{
                viewModel.foodsInRefri = foodsInRefri
                viewModel.recipeData = recipeData
                viewModel.recipeIdsforFilter = filterRecipes
                viewModel.checkRefriFoodsInRecipe()
                print("checkRefriFoodsInRecipe")
            }
            
            if isFirstLaunch { // 사용자의 기기에서 첫 실행때만 동작
//                CSVUtils.saveFoodData(fooddata: &foodCSVData, modelContext: modelContext)
                CSVUtils.saveRecipeData(fooddata: &recipeCSVData, modelContext: modelContext)
                print("Run CSV File")
                
                DispatchQueue.main.async{
                    let beggar = BeggarsList().beggars[0]
                    let name = beggar.name
                    let image = beggar.image
                    let goalMoney = beggar.goalMoney
                    modelContext.insert(Beggars(stage: 0, name: name, image: image, goalMoney: goalMoney, nowMoney: 0))
                }
                
                isFirstLaunch = false
            }
        }
    }
       
}
