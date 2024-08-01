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
    @Environment(NavigationManager.self) var navigationManager
    @State private var recipe = Recipe(thumbnail: Image("감바스 알 아히요"))
    
    var body: some View {
        ZStack {
            Color(red: 255/255, green: 250/255, blue: 233/255)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Divider()
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                
                List {
                    ForEach(recipe.menus, id: \.self) { menu in
                        Button(action: {navigationManager.push(to: .recipeDetail)}){
                            VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                recipe.thumbnail
                                    .resizable()
                                    .frame(width: 110, height: 70)
                                    .cornerRadius(4)
                                    .padding(.leading, 16)
                                
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
                                Divider()
                                  .padding(8)

                        }
                        }
                    }
                    .onDelete(perform: deleteMenu)
                    .listRowBackground(Color(red: 255/255, green: 250/255, blue: 233/255))
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                }
                .onAppear{
                    UITableView.appearance().backgroundColor = .clear
                }
                .listStyle(.plain)
//                .environment(\.defaultMinListRowHeight, 0)
                
                Button(action: {navigationManager.push(to: .recipeAdd)}, label: {Image("AddRecipeButton").resizable()
                        .frame(maxWidth: 300, maxHeight: 60)
                        .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 80)})
            }
        }
        .navigationTitle("레시피 관리")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func deleteMenu(at offsets: IndexSet) {
        recipe.menus.remove(atOffsets: offsets)
    }
    
}


#Preview {
    RecipeView()
}


//import SwiftUI
//
//struct RecipeView: View {
//    @Environment(NavigationManager.self) var navigationManager
//
//    var body: some View {
//        VStack {
//            Text("RefriView")
//            Button("어쩌구저쩌구레시피"){
//                navigationManager.push(to: .recipeDetail)
//            }
//            Button("레시피 추가 버튼") {
//                navigationManager.push(to: .recipeAdd)
//            }
//        }
//        .navigationDestination(for: PathType.self) { pathType in
//            pathType.NavigatingView()
//        }
//    }
//}
//
//#Preview {
//    RecipeView()
//        .environment(NavigationManager())
//}
