//
//  MainView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//


import SwiftUI

struct MainView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    @State private var progressValue: Float = 20000
    @State private var maxValue: Float = 20000
    
    var body: some View {
        ZStack{
            // 배경 색
            Color(red: 255/255, green: 250/255, blue: 233/255)
                .ignoresSafeArea()
            
            VStack {
                // 커스텀 프로그레스 바
                CustomProgressBar(value: progressValue, maxValue: maxValue)
                    .frame(height: 40)
                    .padding(EdgeInsets(top: 30, leading: 27, bottom: 30, trailing: 27))
                
                
                // 첫번째 줄 버튼 두개
                HStack{
                    Button(action: {
                        // 거지의전당 버튼 액션
                        navigationManager.push(to:.cookChoiceFood)
                    }) {
                        Image("MainBeggarCollection")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 77)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // 냉장고 버튼 액션
                        navigationManager.push(to:.refri)
                    }) {
                        Image("MainRefriButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 77)
                    }
                }.padding(.horizontal, 13)
                
                // 두번째 줄 버튼
                HStack{
                    Spacer()
                    
                    Button(action: {
                        // 레시피 버튼 액션
                        navigationManager.push(to:.recipe)
                    }) {
                        Image("MainRecipeButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 77)
                    }
                    
                }.padding(.horizontal, 13)
                
                Spacer()
                
                // Text Box
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.black)
                        .frame(width: 300, height: 80)
                        .overlay(
                            VStack {
                                Text("미스탕후루씨")
                                    .foregroundColor(.yellow)
                                    .bold()
                                
                                Text("오늘은 마라탕을 먹고 싶어....")
                                    .foregroundColor(.white)
                            }
                        )
                }
                .padding()
                
                // 요리하기 버튼
                Button(action: {
                    // 요리하기 버튼 액션
                    UINavigationBar.setAnimationsEnabled(false)
                    navigationManager.push(to:.cookChoiceFood)
                }) {
                    Image("MainCookButton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 230, maxHeight: 70)
                }
                .padding(.bottom, 50)
            }
        }.navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
    }
}
// 프로그레스바 커스텀
struct CustomProgressBar: View {
    var value: Float
    var maxValue: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // 프로그레스 바 배경
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color(red: 255/255, green: 250/255, blue: 233/255))
                    .frame(width: geometry.size.width, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.black, lineWidth: 2)
                    )
                
                // 프로그레스 바
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 1, green: 0.69, blue: 0.32), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.97, green: 0.53, blue: 0.28), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
                    .frame(
                        width: min(CGFloat(self.value / self.maxValue) * (geometry.size.width - 12), geometry.size.width - 12),
                        height: 28
                    )
                    .padding(.horizontal, 6)
            }
        }
        .frame(height: 40)
        .overlay(
            Text("\(Int(value)) / \(Int(maxValue))")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
        )
    }
}

//import SwiftUI
//
//struct MainView: View {
//    @Environment(NavigationManager.self) var navigationManager
//    
//    var body: some View {
//        VStack {
//            Text("MainView")
//            Button("냉장고 버튼") {
//                navigationManager.push(to: .refri)
//            }
//            Button("레시피 버튼") {
//                navigationManager.push(to: .recipe)
//            }
//            Button("요리하기 버튼") {
//                    UINavigationBar.setAnimationsEnabled(false)
//                    navigationManager.push(to:.cookChoiceFood)
//                    
//            }
//        }
//        .navigationDestination(for: PathType.self) { pathType in
//            pathType.NavigatingView()
//        }
//    }
//}
//
//#Preview {
//    MainView()
//        .environment(NavigationManager())
//}
//
