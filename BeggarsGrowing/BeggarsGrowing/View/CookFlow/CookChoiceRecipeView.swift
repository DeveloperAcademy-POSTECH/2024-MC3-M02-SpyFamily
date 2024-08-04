//
//  CookChoiceRecipeView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//
//

import SwiftUI
import SwiftData

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
    @EnvironmentObject var viewModel: CookViewModel
    
    @Query var recipeData: [Recipe]
    @Query var foodsInRefri: [Refrigerator]
    
    var foodsInRefriStrings: [String] { foodsInRefri.map {$0.food} }
    
    var recommendedRecipes: [Recipe] = []
    
    var body: some View {
        ZStack {
            Color(red: 255/255, green: 250/255, blue: 233/255)
                .ignoresSafeArea()
            
            VStack {
                Divider()
                    .foregroundColor(.black)
                    .padding()
                
                VStack {
                    ScrollView {
                        ForEach(viewModel.recommendedRecipeByRefri, id: \.self) { recipe in
//                            let sortedFoods: [String] = {
//                                var includedFoodsInRefri: [String] = []
//                                var remainingFoods: [String] = []
//                                for food in recipe.foods {
//                                    if foodsInRefriStrings.contains(food) {
//                                        includedFoodsInRefri.append(food)
//                                    } else {
//                                        remainingFoods.append(food)
//                                    }
//                                }
//                                return includedFoodsInRefri + remainingFoods
//                            }()
                            
                            Button(action: {
                                viewModel.selectedRecipe = recipe
                                let selectingFoodsForUse = foodsInRefri.filter { recipe.foods.contains($0.food)}
                                viewModel.usedFoods = selectingFoodsForUse.map { ($0, 0) }
                                navigationManager.push(to: .cookRecipeDetail)},
                                   label: {
                                ZStack {
                                    Image(recipe.image ?? "")
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
                                                        Text(recipe.menu)
                                                            .font(.headline)
                                                            .foregroundColor(.black)
                                                            .padding(.bottom, 10)
                                                        Spacer()
                                                    }
                                                    .padding(.leading, 8)
                                                    HStack(spacing: 0) {
//                                                        ForEach(recipe.foods, id: \.self) { ingredients in
//                                                            Text(sortedFoods[ingredients])
//                                                                .foregroundColor(recipe.foodsInRefri.contains(sortedFoods[ingredients]) ? Color(red: 64/255, green: 198/255, blue: 137/255) : .black)
//                                                                .fontWeight(recipe.foodsInRefri.contains(sortedFoods[ingredients]) ? .bold : .regular)
//                                                                .lineLimit(1)
//                                                            //마지막 쉼표 빼는거
//                                                            if ingredients != sortedFoods.count - 1 {
//                                                                Text(", ")
//                                                                    .foregroundColor(.black)
//                                                            }
//                                                        }
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
