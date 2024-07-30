//
//  RecipeView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct RecipeView: View {
    struct Recipe {
        var thumbnail: Image
        var menus = ["손님 왔을때 하기 좋은 요리", "감바스 알 아히요", "토마토달걀볶음", "새우볶음밥", "완죤 맛있는 새우새우", "칠리 새우 레시피"]
        var foods = ["당근", "새우", "버섯", "마늘", "양파"]
    }

    var body: some View {
        let recipe = Recipe(thumbnail: Image("감바스 알 아히요"))
        
        NavigationStack {
            ZStack {
                Color(red: 255/255, green: 250/255, blue: 233/255)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Divider()
                        .foregroundColor(.black)
                        .padding()

                    ScrollView {
                        ForEach(recipe.menus, id: \.self) { menu in
                            Button(action: {}, label: {
                                HStack(spacing: 0) {
                                    recipe.thumbnail
                                        .resizable()
                                        .frame(width: 110, height: 70)
                                        .cornerRadius(4)
                                    
                                    VStack(spacing: 0) {
                                        HStack {
                                            Text(menu)
                                                .foregroundColor(.black)
                                                .lineLimit(1)
                                                .truncationMode(.tail)
                                                .padding(.leading, 20)
                                            Spacer()
                                        }
                                        .padding(.bottom, 10)
                                        HStack {
                                            ForEach(recipe.foods, id: \.self) { food in
                                                Text("#\(food)")
                                                    .foregroundColor(.gray)
                                                    .font(.subheadline)
                                            }
                                            Spacer()
                                        }
                                        .truncationMode(.tail)
                                        .lineLimit(1)
                                        .padding(.leading, 20)
                                    }
                                }
                                .padding(.horizontal, 16)
                            })
                            Divider()
                                .foregroundColor(.black)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 4)
                        }
                    }
                    Spacer()
                    Image("AddRecipeButton")
                        .padding(.bottom, 80)
                }
            }
            .navigationTitle("레시피 관리")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    RecipeView()
}
