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
    case cookChoiceFood
    case cookChoiceRecipe
    case cookRecipeDetail
    case cookRecord
    case cookRecordCamera
    case recipeAddLink
    case recipeAddMemo
    case recipeAddName
    case recipeAddPicture
    case recipeAddFoodSauce
    case beggarsHOF
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
            
        case .recipeAddLink:
            RecipeAddView_Link()
            
        case .recipeAddMemo:
            RecipeAddView_Memo()
            
        case .recipeAddName:
            RecipeAddView_Name()
            
        case .recipeAddPicture:
            RecipeAddView_Picture()
            
        case .recipeAddFoodSauce:
            RecipeAddView_FoodSauce()
            
        case .cookChoiceFood:
            CookChoiceFoodView()
            
        case .cookChoiceRecipe:
            CookChoiceRecipeView()
            
        case .cookRecipeDetail:
            CookRecipeDetailView()
            
        case .cookRecord:
            CookRecordView()
            
        case .cookRecordCamera:
            CookCameraView()
            
        case .beggarsHOF:
            BeggarsHOFView()
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

