//
//  CookRecipeDetailView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct CookRecipeDetailView: View {
    @Environment(NavigationManager.self) var navigationManager
    @EnvironmentObject var viewModel: CookViewModel
    
    @State var recipe: Recipe = Recipe(menu: "", foods: [""], foodsAmount: [""])
    @State private var isAlertPresented = false
    
    private var imageName = FoodImageName()
    
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
                                Text(recipe.link ?? "링크가 없습니다.")
                                    .foregroundColor(.blue)
                                    .underline()
                                    .lineLimit(1)
                                    .truncationMode(.tail)
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
                        
                        ForEach(Array(recipe.foods.enumerated()), id: \.offset) { index, foodName in
                            HStack(spacing: 0){
                                Image(imageName.getImageName(for: foodName) ?? "")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(.trailing, 10)
                                Text(foodName)
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
                        if recipe.sauces?.count ?? 0 >= 1{
                            ForEach(Array(recipe.sauces?.enumerated() ?? [""].enumerated()), id: \.offset) { index, sauceName in
                                HStack(spacing: 0){
                                    Text(sauceName)
                                        .font(.system(size: 17))
                                    Spacer()
                                    if let saucesAmount = recipe.saucesAmount {
                                        Text("\(saucesAmount[index])")
                                            .font(.system(size: 17))
                                    } else {
                                        Text("??")
                                    }
                                }
                                .padding(.vertical, 14)
                                .padding(.leading, 10)
                                .padding(.trailing, 20)
                            }
                        } else {
                            Text("기타 소스가 없습니다.")
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
                    
                    Button(action: {
                        navigationManager.push(to: .cookRecord)
                        
                    }, label: {
                        Image("RecordPhoto")
                            .resizable()
                            .frame(maxWidth: 300, maxHeight: 60)
                            .aspectRatio(contentMode: .fit)
                    })
                    .padding(.bottom, 66)
                    .navigationDestination(for: PathType.self) { pathType in
                        pathType.NavigatingView()
                    }
                    
                }
            }
        }
        .navigationBarItems(trailing: Button(action: {
            isAlertPresented.toggle()
        }) {
            Image(systemName: "xmark")
                .foregroundColor(.black)
        })
        .alert(isPresented: $isAlertPresented) {
            Alert(
                title: Text("경고"),
                message: Text("요리 입력을 중단하시겠습니까?"),
                primaryButton: .destructive(Text("닫기")) {
                    navigationManager.pop(to: .main)
                },
                secondaryButton: .cancel(Text("취소"))
            )
        }
        .onAppear{
            self.recipe = viewModel.selectedRecipe
        }
    }
}
