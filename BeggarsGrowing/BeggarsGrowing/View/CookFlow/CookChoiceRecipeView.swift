//
//  CookChoiceRecipeView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct CookChoiceRecipeView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    var body: some View {
        VStack {
            Text("CookChoiceRecipeView")
            Button("요리 선택 완료") {
                navigationManager.push(to: .cookRecipeDetail)
            }
        }
        .navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
    }
}

#Preview {
    CookChoiceRecipeView()
        .environment(NavigationManager())
}
