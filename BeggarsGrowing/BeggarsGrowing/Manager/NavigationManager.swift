//
//  NavigationManager.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//


import SwiftUI

enum PathType: Hashable {
    case main
    case refri
    case refriAddFood
    case recipe
    case recipeDetail
    case recipeAdd
    case cookChoiceFood
    case cookChoiceRecipe
    case cookRecipeDetail
    case cookRecord
    case cookRecordCamera
}

extension PathType {
    @ViewBuilder
    func NavigatingView() -> some View {
        switch self {
            
        case .main:
            MainView()
                .navigationBarHidden(true)
            
        case .refri:
            RefriView()
            
        case .refriAddFood:
            RefriAddFoodView()
            
        case .recipe:
            RecipeView()
            
        case .recipeDetail:
            RecipeDetailView()
            
        case .recipeAdd:
            RecipeAddView()
            
        case .cookChoiceFood:
            CookChoiceFoodView()
//                .environmentObject(CookViewModel())
//                .navigationBarHidden(true)
            
        case .cookChoiceRecipe:
            CookChoiceRecipeView()
            
        case .cookRecipeDetail:
            CookRecipeDetailView()
            
        case .cookRecord:
            CookRecordView()
            
        case .cookRecordCamera:
            CookCameraView()
                .navigationBarHidden(true)
        }
    }
}

@Observable
class NavigationManager {
    var path: [PathType]
    init(
        path: [PathType] = []
    ){
        self.path = path
    }
}

extension NavigationManager {
    func push(to pathType: PathType) {
        path.append(pathType)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    func pop(to pathType: PathType) {
        guard let lastIndex = path.lastIndex(of: pathType) else { return }
        path.removeLast(path.count - (lastIndex + 1))
    }
}

