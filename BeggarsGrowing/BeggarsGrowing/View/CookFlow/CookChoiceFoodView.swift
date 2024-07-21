//
//  CookChoiceFoodView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct CookChoiceFoodView: View {
    @Environment(NavigationManager.self) var navigationManager
    @State private var showView = false
    
    var body: some View {
        ZStack{
            
            Color.yellow
                .ignoresSafeArea()
            
            VStack {
                Text("CookChoiceFoodView")
                Button("재료 선택 완료") {
                    navigationManager.push(to: .cookChoiceRecipe)
                }
            }
        }
        .mask(
            Circle()
                .scale(showView ? 3 : 0.1) // 원의 크기 조절
                .animation(.easeInOut(duration: 0.5), value: showView) // 애니메이션 설정
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // 화면 크기에 맞게 원 크기 설정
        )
        //        .opacity(showView ? 1 : 0)
        //        .animation(.easeInOut(duration: 0.5), value: showView)
        .navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
        .onAppear{
            showView = true
            UINavigationBar.setAnimationsEnabled(true)
        }
    }
}

#Preview {
    CookChoiceFoodView()
        .environment(NavigationManager())
}
