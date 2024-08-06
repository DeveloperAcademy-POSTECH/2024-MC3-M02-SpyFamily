//
//  RecipeAddView_FoodSauce.swift
//  BeggarsGrowing
//
//  Created by 이예형 on 7/31/24.
//

import SwiftUI

struct RecipeAddView_FoodSauce: View {
    @Environment(NavigationManager.self) var navigationManager
    @EnvironmentObject var viewModel: RecipeViewModel
    
    let numbers = [1, 2, 3, 4, 5]
    
    @State var showingSelectFoodSheet: Bool = false
    @State var foodNames: [String] = []
    @State var foodQuantities: [String] = []
    
    @State var showingSelectSauceSheet: Bool = false
    @State var SauceNames: [String] = []
    @State var SauceQuantities: [String] = []
    
    @State private var isAlertPresented = false
    
    private var imageName = FoodImageName()
    
    var body: some View {
        ZStack{
            Color(red: 255/255, green: 250/255, blue: 233/255)
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack(spacing: 0){
                    Divider()
                        .frame(minHeight: 1)
                        .background(Color.black)
                        .padding(.bottom, 30)
                    HStack(spacing: 0){
                        ForEach(numbers, id: \.self) { number in
                            ZStack {
                                Circle()
                                    .fill(number == 4 ? Color(red: 246/255, green: 153/255, blue: 39/255) : Color(red: 242/255, green: 245/255, blue: 240/255)
                                    )
                                    .frame(width: 30, height: 30)
                                Text("\(number)")
                                    .foregroundColor(number == 4 ? Color.white : Color.black)
                                    .font(.system(size: 17))
                                    .bold()
                            }
                            .padding(.trailing, 10)
                        }
                        Spacer()
                        
                    }
                    .padding(.bottom, 40)
                    HStack(spacing: 0){
                        Text("재료 등록")
                            .font(.system(size: 22))
                            .fontWeight(.heavy)
                        Spacer()
                        Button(action:{
                            showingSelectFoodSheet.toggle()
                        }, label:{
                            Image(systemName: "plus.rectangle.fill")
                                .resizable()
                                .frame(width: 32, height: 25)
                                .foregroundColor(Color(red: 246/255, green: 153/255, blue: 39/255))
                                .padding(.trailing, 4)
                        })
                        
                    }
                    .padding(.bottom, 10)
                    Divider()
                        .frame(minHeight: 1)
                        .background(Color.black)
                        .padding(.bottom, 9)
                    
                    ForEach(foodNames.indices, id: \.self) { index in
                        HStack(spacing: 0){
                            Button(action:{
                                foodNames.remove(at: index)
                                foodQuantities.remove(at: index)
                            }, label:{
                                Image(systemName: "minus.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 15)
                            })
                            Image(imageName.getImageName(for: foodNames[index]) ?? "")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .padding(.trailing, 7)
                            Text(foodNames[index])
                                .font(.system(size: 17))
                                .fontWeight(.heavy)
                            Spacer()
                            TextField("용량과 단위", text: $foodQuantities[index])
                                .frame(width: 140)
                                .textFieldStyle(TextfieldStyle())
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    
                    HStack(spacing: 0){
                        Text("소스 등록")
                            .font(.system(size: 22))
                            .fontWeight(.heavy)
                        Spacer()
                        Button(action:{
                            showingSelectSauceSheet.toggle()
                        }, label:{
                            Image(systemName: "plus.rectangle.fill")
                                .resizable()
                                .frame(width: 32, height: 25)
                                .foregroundColor(Color(red: 246/255, green: 153/255, blue: 39/255))
                                .padding(.trailing, 4)
                        })
                    }
                    .padding(.bottom, 10)
                    .padding(.top, 45)
                    
                    Divider()
                        .frame(minHeight: 1)
                        .background(Color.black)
                        .padding(.bottom, 9)
                    ForEach(SauceNames.indices, id: \.self) { index in
                        HStack(spacing: 0){
                            Button(action:{
                                SauceNames.remove(at: index)
                                SauceQuantities.remove(at: index)
                            }, label:{
                                Image(systemName: "minus.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 20)
                            })
                            Text(SauceNames[index])
                                .font(.system(size: 17))
                                .fontWeight(.heavy)
                            Spacer()
                            TextField("용량과 단위", text: $SauceQuantities[index])
                                .frame(width: 140)
                                .textFieldStyle(TextfieldStyle())
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    
                    Button(action:{
                        viewModel.inputFoods = foodNames
                        viewModel.inputFoodsAmount = foodQuantities
                        viewModel.inputSauces = SauceNames
                        viewModel.inputSaucesAmount = SauceQuantities
                        navigationManager.push(to: .recipeAddMemo)
                    }, label:{
                        Text("입력 완료")
                    })
                }
                
                .padding(.horizontal, 16)
            }
        }
        .onAppear{
            foodNames = viewModel.inputFoods
            foodQuantities = viewModel.inputFoodsAmount
            SauceNames = viewModel.inputSauces
            SauceQuantities = viewModel.inputSaucesAmount
        }
        .sheet(isPresented: $showingSelectFoodSheet){
            RecipeSelectFoodSheetView(selectedFoodsList: $foodNames, selectedFoodsAmountList: $foodQuantities)
                .presentationDetents([.fraction(0.75)]) // 시트 높이를 3/4로 설정
        }
        .sheet(isPresented: $showingSelectSauceSheet){
            RecipeSelectSauceSheetView(selectedSaucesList: $SauceNames, selectedSaucesAmountList: $SauceQuantities)
                .presentationDetents([.fraction(0.75)]) // 시트 높이를 3/4로 설정
        }
        .navigationTitle("레시피 등록")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            isAlertPresented.toggle()
        }) {
            Image(systemName: "xmark")
                .foregroundColor(.black)
        })
        .alert(isPresented: $isAlertPresented) {
            Alert(
                title: Text("경고"),
                message: Text("레시피 입력을 중단하시겠습니까?"),
                primaryButton: .destructive(Text("닫기")) {
                    navigationManager.pop(to: .recipe)
                },
                secondaryButton: .cancel(Text("취소"))
            )
        }
    }
}

struct TextfieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 2)
                .stroke(Color.gray, lineWidth: 1) // 검정색 테두리
                .frame(height: 44)
            
            // 텍스트필드
            configuration
                .font(.system(size: 17))
                .padding(11)
        }
    }
}

