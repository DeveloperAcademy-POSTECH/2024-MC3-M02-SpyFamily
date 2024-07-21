//
//  RefriView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct RefriView: View {
    @Environment(NavigationManager.self) var navigationManager

    var body: some View {
        VStack {
            Text("RefriView")
            Button("냉장고 재료 추가 버튼") {
                navigationManager.push(to: .refriAddFood)
            }
        }
        .navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
    }
}

#Preview {
    RefriView()
        .environment(NavigationManager())
}
