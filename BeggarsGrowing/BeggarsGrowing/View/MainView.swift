//
//  MainView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct MainView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    var body: some View {
        VStack {
            Text("MainView")
            Button("냉장고 버튼") {
                navigationManager.push(to: .refri)
            }
            Button("레시피 버튼") {
                navigationManager.push(to: .recipe)
            }
            Button("요리하기 버튼") {
                    UINavigationBar.setAnimationsEnabled(false)
                    navigationManager.push(to:.cookChoiceFood)
                    
            }
        }
        .navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
    }
}

#Preview {
    MainView()
        .environment(NavigationManager())
}

