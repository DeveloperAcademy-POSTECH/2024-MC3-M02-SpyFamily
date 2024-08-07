//
//  RecipeView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//
//

import SwiftUI
import SwiftData

struct RecipeView: View {
    @Environment(NavigationManager.self) var navigationManager
    @EnvironmentObject var viewModel: RecipeViewModel
    @EnvironmentObject var cookViewModel: CookViewModel
    @Environment(\.modelContext) private var modelContext
    
    @Query var recipes: [Recipe]
    @Query var filterRecipes: [FilterRecipe]
    @Query var foodsInRefri: [Refrigerator]
    
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
                                    
                                    if let recipeImage = recipe.image {
                                        if isValidUUID(uuidString: recipeImage){
                                            if let loadedImage = loadImage(imageName: recipeImage) {
                                                Image(uiImage: loadedImage)
                                                    .resizable()
                                                    .frame(width: 110, height: 70)
                                                    .cornerRadius(4)
                                                    .padding(.leading, 16)
                                            } else {
                                                Image("")
                                                    .resizable()
                                                    .frame(width: 110, height: 70)
                                                    .cornerRadius(4)
                                                    .padding(.leading, 16)
                                            }
                                        } else {
                                            Image(recipeImage)
                                                .resizable()
                                                .frame(width: 110, height: 70)
                                                .cornerRadius(4)
                                                .padding(.leading, 16)
                                        }
                                    }
                                    
                                    
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
                Button(action: {
                    viewModel.reset()
                    navigationManager.push(to: .recipeAddName)
                }, label: {
                    Image("AddRecipeButton").resizable()
                        .frame(maxWidth: 300, maxHeight: 60)
                        .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 80)})
            }
        }
        .onChange(of:recipes){
            DispatchQueue.main.async{
                cookViewModel.foodsInRefri = foodsInRefri
                cookViewModel.recipeData = recipes
                cookViewModel.recipeIdsforFilter = filterRecipes
                cookViewModel.checkRefriFoodsInRecipe()
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

func loadImage(imageName: String) -> UIImage? {
    let fileManager = FileManager.default
    let imagePath = getDocumentsDirectory().appendingPathComponent("\(imageName).png").path
    if fileManager.fileExists(atPath: imagePath) {
        return UIImage(contentsOfFile: imagePath)
    }
    return nil
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func isValidUUID(uuidString: String) -> Bool {
    return UUID(uuidString: uuidString) != nil
}
