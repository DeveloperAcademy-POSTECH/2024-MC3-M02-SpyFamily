//
//  RecipeSelectSauceSheet.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 8/2/24.
//


import SwiftUI

struct RecipeSelectSauceSheetView: View {
    @State private var searchText = ""
    @State private var selectedIngredients: Set<String> = []
    @Environment(\.presentationMode) var presentationMode
    
    let foods = FoodImageName().ingredients
    
    @Binding var selectedSaucesList: [String]
    @Binding var selectedSaucesAmountList: [String]
    
    var filteredFoods: [Food] {
        if searchText.isEmpty {
            return foods
        } else {
            return foods.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                Text("재료")
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                Spacer()
                Button(action: {
                    // 완료 버튼 액션
                    DispatchQueue.main.async{
                        for food in selectedIngredients {
                            selectedSaucesList.append(food)
                            selectedSaucesAmountList.append("")
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }){
                    Text("완료")
                        .foregroundColor(.orange)
                        .font(.system(size: 16))
                        .fontWeight(.heavy)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 26)
            .padding(.top, 17)
            SearchBar(text: $searchText)
                .frame(height: 36)
                .padding(.horizontal, 8)
                .padding(.bottom, 9)
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(filteredFoods, id: \.name) { food in
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(selectedIngredients.contains(food.name) ? Color.yellow.opacity(0.3) : Color(red: 242/255, green: 245/255, blue: 240/255))
                                .frame(height: 50)
                            HStack(spacing: 0){
                                Button(action: {
                                    if selectedIngredients.contains(food.name) {
                                        selectedIngredients.remove(food.name)
                                    } else {
                                        selectedIngredients.insert(food.name)
                                    }
                                }) {
                                    Image(systemName: selectedIngredients.contains(food.name) ? "checkmark.square.fill" : "square")
                                        .font(.title3)
                                        .foregroundColor(.orange)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(.leading, 15)
                                Image(food.imageName)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(.leading, 20)
                                Text(food.name)
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .padding(.leading, 10)

                                Spacer()
                            }
                        }
                        .padding(.bottom, 8)
                    }
                }
                .padding(.horizontal, 16)

            } // scrl
        } //v
    }
}
