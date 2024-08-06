//
//  RecipeDetailView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct RecipeDetailView: View {
    @Environment(NavigationManager.self) var navigationManager
    @EnvironmentObject var viewModel: RecipeViewModel
    var imageName = FoodImageName()
    
    @State var recipe = Recipe(menu: "", foods: [""], foodsAmount: [""])
    
    var body: some View {
        ZStack{
            Color(red: 255 / 255, green: 250 / 255, blue: 233 / 255)
                .ignoresSafeArea()
            ScrollView{
                VStack(spacing: 0){
                    if let recipeImage = recipe.image {
                        if isValidUUID(uuidString: recipeImage){
                            if let loadedImage = loadImage(imageName: recipeImage) {
                                Image(uiImage: loadedImage)
                                    .resizable()
                                    .frame(height: 233)
                                    .cornerRadius(4)
                                    .padding(12)
                            } else {
                                Rectangle() //레시피 이미지
                                    .foregroundColor(.gray)
                                    .frame(height: 233)
                                    .padding(12)
                            }
                        } else {
                            Image(recipeImage)
                                .resizable()
                                .frame(height: 233)
                                .cornerRadius(4)
                                .padding(12)
                        }
                    }
                    VStack(alignment: .leading, spacing: 0){
                        HStack{
                            Text(recipe.menu)
                                .font(.system(size: 28))
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        .padding(.bottom, 15)
                        Text("요리 레시피 링크")
                            .font(.system(size: 17))
                            .fontWeight(.heavy)
                            .padding(.bottom, 10)
                        HStack(spacing: 0){
                            Image(systemName: "link")
                                .foregroundColor(.blue)
                                .bold()
                                .padding(.trailing, 5)
                            Button(action:{
                                URLUtils.openLink(urlString: recipe.link ?? "")
                            }, label:{
                                Text(recipe.link ?? "")
                                    .foregroundColor(.blue)
                                    .underline()
                                    .lineLimit(1)
                                    .truncationMode(.tail) //넘치는 텍스트 말줄임표 표시
                            })
                            
                        }
                        .padding(.bottom, 15)
                        Text("재료")
                            .font(.system(size: 17))
                            .fontWeight(.heavy)
                            .padding(.bottom, 6)
                        
                        Divider()
                            .frame(minHeight: 1)
                            .background(Color.black)
                            .padding(.bottom, 4)
                        ForEach(Array(recipe.foods.enumerated()), id: \.offset) { index, food in
                            HStack(spacing: 0){
                                Image(imageName.getImageName(for: food) ?? "")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(.trailing, 10)
                                Text(food)
                                    .font(.system(size: 17))
                                Spacer()
                                Text(recipe.foodsAmount[index])
                                    .font(.system(size: 17))
                            }
                            .padding(.vertical, 14)
                            .padding(.leading, 10)
                            .padding(.trailing, 20)
                        }
                        Text("소스")
                            .font(.system(size: 17))
                            .fontWeight(.heavy)
                            .padding(.top, 16)
                            .padding(.bottom, 6)
                        Divider()
                            .frame(minHeight: 1)
                            .background(Color.black)
                            .padding(.bottom, 8)
                        if let sauces = recipe.sauces{
                            ForEach(Array(sauces.enumerated()), id: \.offset) { index, sauce in
                                HStack(spacing: 0){
                                    Text(sauce)
                                        .font(.system(size: 17))
                                    Spacer()
                                    Text(recipe.saucesAmount?[index] ?? "")
                                        .font(.system(size: 17))
                                }
                                .padding(.vertical, 14)
                                .padding(.leading, 10)
                                .padding(.trailing, 20)
                            }
                        }

                        Text("메모")
                            .font(.system(size: 17))
                            .fontWeight(.heavy)
                            .padding(.top, 18)
                            .padding(.bottom, 8)
                        
                        
                        Divider()
                            .frame(minHeight: 1)
                            .background(Color.black)
                            .padding(.bottom, 8)
                        ZStack(alignment: .topLeading){
                            RoundedRectangle(cornerRadius: 6)
                                .frame(height: 200)
                                .foregroundColor(Color(red: 252 / 255, green: 239 / 255, blue: 209 / 255))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.gray, lineWidth: 1))
                            Text(recipe.memo ?? "")
                                .padding(10)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 50)
                }
            }
        }
        .navigationTitle("레시피")
        .onAppear{
            recipe = viewModel.selectedRecipeforDetail
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
