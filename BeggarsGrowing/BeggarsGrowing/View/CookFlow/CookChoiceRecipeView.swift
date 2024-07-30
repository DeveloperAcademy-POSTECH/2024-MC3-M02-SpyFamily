//
//  CookChoiceRecipeView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//
//

import SwiftUI

// 특정 모서리 둥글게 만드는 부분
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
// // //

struct CookChoiceRecipeView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    struct Recipe {
        var thumbnail: Image
        var menus = "감바스 알 아히요"
        var foods = ["당근", "계란", "바게트", "양파", "짱하연", "완죤 잘 익은 토마토"]
        var foodsInRefri = ["당근", "계란", "바게트", "사과"]
    }
    
    var body: some View {
        let recipe = Recipe(thumbnail: Image("감바스 알 아히요"))
        //재료들 중 냉장고에 있는거
        let includedFoodsInRefri = recipe.foods.filter { recipe.foodsInRefri.contains($0) }
        //재료들 중 냉장고에 없는 나머지애들
        let remainingFoods = recipe.foods.filter { !recipe.foodsInRefri.contains($0) }
        //위 두개 합쳐서 만든 배열
        let sortedFoods = includedFoodsInRefri + remainingFoods
        
        
        ZStack {
            Color(red: 255/255, green: 250/255, blue: 233/255)
                .ignoresSafeArea()
            
            VStack {
                Divider()
                    .foregroundColor(.black)
                    .padding()
                
                VStack {
                    ScrollView {
                        ForEach(sortedFoods, id: \.self) { food in
                            Button(action: {navigationManager.push(to: .cookRecipeDetail)}, label: {
                                ZStack {
                                    recipe.thumbnail
                                        .resizable()
                                        .frame(width: 330, height: 180)
                                        .cornerRadius(8, corners: [.topLeft, .topRight])
                                        .overlay(
                                            ZStack {
                                                Rectangle()
                                                    .frame(width: 330, height: 70)
                                                    .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                                                    .foregroundColor(.white)
                                                VStack(spacing: 0) {
                                                    HStack {
                                                        Text(recipe.menus)
                                                            .font(.headline)
                                                            .foregroundColor(.black)
                                                            .padding(.bottom, 10)
                                                        Spacer()
                                                    }
                                                    .padding(.leading, 8)
                                                    HStack(spacing: 0) {
                                                        ForEach(sortedFoods.indices, id: \.self) { ingredients in
                                                            Text(sortedFoods[ingredients])
                                                                .foregroundColor(recipe.foodsInRefri.contains(sortedFoods[ingredients]) ? Color(red: 64/255, green: 198/255, blue: 137/255) : .black)
                                                                .fontWeight(recipe.foodsInRefri.contains(sortedFoods[ingredients]) ? .bold : .regular)
                                                                .lineLimit(1)
                                                            //마지막 쉼표 빼는거
                                                            if ingredients != sortedFoods.count - 1 {
                                                                Text(", ")
                                                                    .foregroundColor(.black)
                                                            }
                                                        }
                                                    }
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                    .padding(.leading, 8)
                                                }
                                            }
                                                .padding(.top, 240)
                                        )
                                }
                                .padding(.bottom, 80)
                            })
                            .shadow(color: Color(red: 196/255, green: 196/255, blue: 196/255), radius: 5)
                        }
                    }
                }
            }
        }
        .navigationTitle("레시피 선택")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
    }
}

//import SwiftUI
//
//struct CookChoiceRecipeView: View {
//    @Environment(NavigationManager.self) var navigationManager
//    
//    var body: some View {
//        VStack {
//            Text("CookChoiceRecipeView")
//            Button("요리 선택 완료") {
//                navigationManager.push(to: .cookRecipeDetail)
//            }
//        }
//        .navigationDestination(for: PathType.self) { pathType in
//            pathType.NavigatingView()
//        }
//    }
//}
//
//#Preview {
//    CookChoiceRecipeView()
//        .environment(NavigationManager())
//}
