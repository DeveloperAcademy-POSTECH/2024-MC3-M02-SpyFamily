//
//  CookRecipeDetailView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct CookRecipeDetailView: View {
    @Environment(NavigationManager.self) var navigationManager
    @EnvironmentObject var viewModel: CookViewModel
    
    var body: some View {
        VStack {
            Text("CookRecipeDetailView")
            Text(viewModel.selectedRecipe.menu)
            Button("인증하러 가기") {
                navigationManager.push(to: .cookRecord)
            }
        }
        .navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
    }
}

#Preview {
    CookRecipeDetailView()
        .environment(NavigationManager())
}
