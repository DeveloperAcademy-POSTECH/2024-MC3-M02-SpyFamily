//
//  RecipeView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct RecipeView: View {
    @Environment(NavigationManager.self) var navigationManager

    var body: some View {
        VStack {
            Text("RefriView")
            Button("어쩌구저쩌구레시피"){
                navigationManager.push(to: .recipeDetail)
            }
            Button("레시피 추가 버튼") {
                navigationManager.push(to: .recipeAdd)
            }
        }
        .navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
    }
}

#Preview {
    RecipeView()
        .environment(NavigationManager())
}
