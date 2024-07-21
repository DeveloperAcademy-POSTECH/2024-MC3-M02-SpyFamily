//
//  ContentView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct ContentView: View {
    @State private var navigationManager = NavigationManager()

    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            VStack {
                Text("여기는 실제로 보이지 않는 화면입니다.")
                Button("메인 화면으로") {
                    navigationManager.push(to: .main)
                }
            }
            .navigationDestination(for: PathType.self) { pathType in
                pathType.NavigatingView()
            }
        }
        .environment(navigationManager)
        
    }
}

#Preview {
    ContentView()
}
