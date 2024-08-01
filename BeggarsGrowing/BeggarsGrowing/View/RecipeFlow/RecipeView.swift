//
//  RecipeView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI
import SwiftData

struct RecipeView: View {
    @Environment(NavigationManager.self) var navigationManager
    @EnvironmentObject var viewModel: RecipeViewModel
    @Environment(\.modelContext) private var modelContext
    
    @Query var recipes: [Recipe]
    
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
                    ForEach(recipes, id: \.self) { recipe in
                        Button(action: {
                            viewModel.selectedRecipeforDetail = recipe
                            navigationManager.push(to: .recipeDetail)
                        }){
                            VStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    Image(recipe.image ?? "")
                                        .resizable()
                                        .frame(width: 110, height: 70)
                                        .cornerRadius(4)
                                        .padding(.leading, 16)
                                    
                                    VStack(spacing: 0) {
                                        HStack {
                                            Text(recipe.menu)
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
        for index in offsets {
            let recipeToDelete = recipes[index]
            modelContext.delete(recipeToDelete)
        }
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
}
