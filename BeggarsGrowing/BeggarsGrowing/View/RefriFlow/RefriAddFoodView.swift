//
//  RefriAddFoodView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct RefriAddFoodView: View {
    @Environment(NavigationManager.self) var navigationManager
    var body: some View {
        
        VStack {
            Text("RefriAddFoodView")
            Button("식재료 채워넣기 완료!") {
                navigationManager.pop()
            }
        }
        .navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
    }
}

#Preview {
    RefriAddFoodView()
        .environment(NavigationManager())
}
