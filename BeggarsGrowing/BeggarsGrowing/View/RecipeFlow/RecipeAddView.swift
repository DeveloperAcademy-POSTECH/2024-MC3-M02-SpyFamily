//
//  RecipeAddView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct RecipeAddView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    var body: some View {
        
        VStack {
            Text("RefriAddFoodView")
            Button("새로운 레시피 추가 완료!") {
                navigationManager.pop()
            }
        }
        .navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
    }
}

#Preview {
    RecipeAddView()
}
