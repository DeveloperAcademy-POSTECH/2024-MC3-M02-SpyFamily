//
//  CookRecipeDetailView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct CookRecipeDetailView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    @State private var foodname: [String] = [
        "돼지고기",
        "배추김치",
        "양파",
        "다진마늘"
    ]
    
    var body: some View {
        ZStack{
            Color(red: 255 / 255, green: 250 / 255, blue: 233 / 255)
                .ignoresSafeArea()
            VStack(spacing: 0){
                Rectangle()
                    .frame(width: 393, height: 233
                    )
                VStack(alignment: .leading, spacing: 0){
                    HStack{
                        Text("돼지고기 김치찌개")
                        Spacer()
                    }
                    Text("요리 레시피 링크")
                    Text("하이퍼링크")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text("재료")
                    Divider()
                        .frame(minHeight: 1)
                        .background(Color.black)
                    ForEach(foodname, id: \.self){foodname in
                        HStack(spacing: 0){
                            Text(foodname)
                            Spacer()
                            Text("10g")
                        }
                    }
                    Text("기타 소스 :")
                    Text("간장, 고추장, 참기름, 설탕")
                    Text("메모")
                    Divider()
                        .frame(minHeight: 1)
                        .background(Color.black)
                    Text("메모 내용")


                }
                .padding(.horizontal, 20)


                Spacer()
                Button("인증하러 가기") {
                    navigationManager.push(to: .cookRecord)
                }
            }
            .navigationDestination(for: PathType.self) { pathType in
                pathType.NavigatingView()
            }
        }
    }
}

#Preview {
    CookRecipeDetailView()
        .environment(NavigationManager())
}
