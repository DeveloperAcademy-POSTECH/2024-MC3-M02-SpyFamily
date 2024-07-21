//
//  CookRecordView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct CookRecordView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    var body: some View {
        VStack {
            Text("CookRecordView")
            Button("인증 완료") {
                navigationManager.popToRoot()
                navigationManager.push(to: .main)
            }
        }
        .navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
    }
}

#Preview {
    CookRecordView()
        .environment(NavigationManager())
}
