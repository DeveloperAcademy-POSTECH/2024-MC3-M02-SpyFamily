//
//  RecipeDetailView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct RecipeDetailView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    var body: some View {
        
        VStack {
            Text("RecipeDetailView")
        }
        .navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
    }
}

#Preview {
    RecipeDetailView()
        .environment(NavigationManager())
}
