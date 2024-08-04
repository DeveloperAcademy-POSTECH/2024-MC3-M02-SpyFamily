//
//  CookSlectFoodSheet.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/31/24.
//
import SwiftUI

struct CookSelectFoodSheetView: View {
    @EnvironmentObject var viewModel: CookViewModel

    @State var searchText = ""
    @State var selectedIngredients: Set<String> = []
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var selectedFoodsList: [Refrigerator]
    var foodsInRefri: [Refrigerator]
    
    //    var foods: [String] {
    //        return foodsInRefri.map { $0.food }
    //    }
    
    var filteredFoods: [Refrigerator] {
        if searchText.isEmpty {
            return foodsInRefri
        } else {
            return foodsInRefri.filter { $0.food.contains(searchText) }
        }
    }
    
    var imageName = FoodImageName()
    
    var body: some View {
        VStack {
            HStack {
                Text("재료")
                    .font(.title)
                    .bold()
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Text("완료")
                        .foregroundColor(.orange)
                }
            }
            .padding()
            
            SearchBar(text: $searchText)
            
            ScrollView {
                VStack(spacing: 10) { // 요소 사이의 여백 설정
                    ForEach(filteredFoods, id: \.self) { food in
                        let foodName = food.food
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(selectedFoodsList.contains(food) ? Color.yellow.opacity(0.3) : Color(red: 242/255, green: 245/255, blue: 240/255))
                            
                            HStack {
                                Button(action: {
                                    if selectedFoodsList.contains(food) {
                                        selectedFoodsList.removeAll { $0 == food }
                                    } else {
                                        selectedFoodsList.append(food)
                                    }
                                }) {
                                    Image(systemName: selectedFoodsList.contains(food) ? "checkmark.square.fill" : "square")
                                        .font(.title3)
                                        .foregroundColor(.orange)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                Image(imageName.getImageName(for: foodName) ?? "")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(.leading)
                                
                                Text(foodName)
                                    .font(.body)
                                    .foregroundColor(.black)
                                
                                Spacer()
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .onAppear{
            
        }
        .padding(.horizontal)
    }
}
