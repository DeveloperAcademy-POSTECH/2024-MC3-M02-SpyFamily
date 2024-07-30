//
//  ContentView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var navigationManager = NavigationManager()
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true // CSV 불러왔는지 True, False로 UserDefaults 저장
    @Environment(\.modelContext) var modelContext
    
//    @State private var foodCSVData: [Food] = []
    
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
        .onAppear {
            if isFirstLaunch { // 사용자의 기기에서 첫 실행때만 동작
//                CSVUtils.saveFoodData(fooddata: &foodCSVData, modelContext: modelContext)
                print("Run CSV File")
                isFirstLaunch = false
            }
        }
    }
       
}
//
//#Preview {
//    ContentView()
//}
