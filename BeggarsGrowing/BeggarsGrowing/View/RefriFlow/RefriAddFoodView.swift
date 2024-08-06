//
//  RefriAddFoodView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI
import SwiftData

struct RefriAddFoodView: View {
    @Environment(NavigationManager.self) var navigationManager
    @Environment(\.modelContext) var modelContext
    
    @State var foodsToAdd: [Refrigerator] = []
    
    @State var showingSelectFoodSheet: Bool = false
    @State var selectedFoodsList: [Food] = []
    private var imageName = FoodImageName()
    
    var body: some View {
        ZStack{
            Color(red: 255 / 255, green: 250 / 255, blue: 233 / 255)
                .ignoresSafeArea()
            VStack(spacing: 0){
                Divider()
                    .frame(minHeight: 1)
                    .background(Color.black)
                    .padding(.top, 1)
                    .padding(.bottom, 20)
                HStack(spacing: 0){
                    Text("재료명")
                        .font(.system(size: 20))
                        .fontWeight(.heavy)
                        .padding(.leading, 59)
                    Spacer()
                    Text("가격")
                        .font(.system(size: 20))
                        .fontWeight(.heavy)
                        .padding(.trailing, 63)
                    Text("냉동")
                        .font(.system(size: 20))
                        .fontWeight(.heavy)
                        .padding(.trailing, 5)
                }
                .padding(.bottom, 15)
                ScrollView {
                    ForEach($foodsToAdd, id:\.id) { $food in
                        HStack(spacing: 0){
                            Button(action:{
                                if let index = foodsToAdd.firstIndex(where: { $0.id == food.id }) {
                                    foodsToAdd.remove(at: index)
                                }
                            }, label:{
                                Image(systemName: "minus.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            })
                            
                            Image(imageName.getImageName(for: food.food) ?? "")
                                .resizable()
                                .frame(width:32, height:32)
                                .padding(.leading, 15)
                            Text(food.food)
                                .padding(.leading, 8)
                            Spacer()
                            TextField("가격", value: $food.price, formatter: NumberFormatter())
                                .frame(width: 109)
                                .textFieldStyle(PriceTextfieldStyle())
                                .keyboardType(.numberPad)
                                .padding(.trailing, 30)
                            Toggle(isOn: $food.freezing) {
                                Text("")
                            }
                            .toggleStyle(CheckboxToggleStyle())
                            .padding(.trailing, 10)
                        }
                        .padding(.vertical, 4)
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 25)
                    Spacer()
                }
            } //-- v스택 끝
            
            VStack(spacing: 0){
                Spacer()
                Button(action: {
                    for foodinRefri in foodsToAdd {
                        modelContext.insert(foodinRefri)
                    }
                    navigationManager.pop()
                }, label: {
                    Image("AddComplete")
                })
                .padding(.bottom, 54)
            }
            
            .padding(.horizontal, 16)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("식재료 추가하기")
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingSelectFoodSheet.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 19, height: 19)
                        .bold()
                        .foregroundColor(.orange)
                        .padding(.trailing, 8)
                })
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    navigationManager.pop()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
            }
        }
        .sheet(isPresented: $showingSelectFoodSheet){
            RefriSelectFoodSheetView(selectedFoodsList: $foodsToAdd)
                .presentationDetents([.fraction(0.75)]) // 시트 높이를 3/4로 설정
        }
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(configuration.isOn ? .black : .black)
                .imageScale(.large)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct PriceTextfieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.white) // 흰색 배경
                .frame(height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 1)
                )
            configuration
                .multilineTextAlignment(.trailing)
                .font(.system(size: 17))
                .padding(10)
        }
    }
}
