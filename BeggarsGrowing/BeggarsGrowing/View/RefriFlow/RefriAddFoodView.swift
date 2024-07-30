//
//  RefriAddFoodView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI
import SwiftData

struct RefriAddFoodView: View {
    // 추가된 필드들을 관리할 배열
    @Environment(NavigationManager.self) var navigationManager
    @Environment(\.modelContext) var modelContext
    
    @State var foodsToAdd: [Refrigerator] = [
//        Refrigerator(food: "", price: 0, amount: 1.0, freezing: false, date: Date())
    ]
    
    @State var showingSelectFoodSheet: Bool = false
    @State var selectedFoodsList: [Food] = []
    private var imageName = FoodImageName()
    
    var body: some View {
        ZStack{
            Color(red: 255 / 255, green: 250 / 255, blue: 233 / 255)
                .ignoresSafeArea()
            VStack(spacing: 0){
                
                //재료-x
                HStack(spacing: 0){
                    Text("재료추가")
                        .font(.system(size: 20))
                        .fontWeight(.heavy)
                    Spacer()
                    Button(action: {
                        showingSelectFoodSheet.toggle()
                    }, label: {
                        Image(systemName: "plus.rectangle.fill")
                            .resizable()
                            .frame(width: 40, height: 34)
                            .foregroundColor(.orange)
                    })
                }
                .padding(.top, 14)
                .padding(.horizontal, 16)
                .padding(.bottom, 47)
                //재료-x
                
                ScrollView {
                    
                    //재료명-가격-냉동
                    HStack(spacing: 0){
                        VStack(spacing: 0){
                            Text("재료명")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .padding(.bottom, 12)
                            ForEach($foodsToAdd, id:\.id) { $food in
                                HStack{
                                    Text(food.food)
                                    Image(imageName.getImageName(for: food.food) ?? "")
                                        .resizable()
                                        .frame(width:32, height:32)
                                }
                                .frame(height:40)
                                .padding(.bottom, 12)
                            }
                        }
                        .padding(.trailing, 16)
                        VStack(spacing: 0){
                            HStack(spacing: 0){
                                Text("가격")
                                    .font(.system(size: 20))
                                    .fontWeight(.heavy)
                                    .padding(.leading, 39)
                                Spacer()
                                Text("냉동")
                                    .font(.system(size: 20))
                                    .fontWeight(.heavy)
                            }
                            .padding(.bottom, 12)
                            ForEach($foodsToAdd) { $index in
                                HStack(spacing: 0){
                                    TextField("가격", value: $index.price, formatter: NumberFormatter())
                                        .textFieldStyle(PriceTextfieldStyle())
                                        .padding(.trailing, 25)
                                    Toggle(isOn: $index.freezing) {
                                        Text("")
                                    }
                                    .toggleStyle(CheckboxToggleStyle())
                                    .padding(0)
                                }
                                .padding(.trailing, 2)
                            }
                        }
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 25)
                    
                    
//                    Button(action: {
//                        foodsToAdd.append(Refrigerator(food: "", price: 0, amount: 1.0, freezing: false, date: Date()))
//                    }) {
//                        ZStack{
//                            Circle()
//                                .frame(width: 60, height: 60)
//                                .foregroundColor(.green)
//                            Text("+")
//                                .font(.system(size: 40))
//                                .foregroundColor(.black)
//                        }
//                    }
//                    .padding(.top, 36)
                    Spacer()
                }
            } //-- v스택 끝
            
            //재료 추가 완료 버튼
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
            //재료 추가 완료 버튼
        }
        .sheet(isPresented: $showingSelectFoodSheet){
            SelectFoodSheetView(selectedFoodsList: $foodsToAdd)
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
                .frame(width: 30, height: 30)
                .foregroundColor(configuration.isOn ? .black : .black)
                .imageScale(.large)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct NameTextfieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.white) // 흰색 배경
                .frame(height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 1) // 검정색 테두리
                )
            
            // 텍스트필드
            configuration
                .font(.system(size: 17))
                .padding()
        }
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
                        .stroke(Color.black, lineWidth: 1) // 검정색 테두리
                )
            
            // 텍스트필드
            configuration
                .multilineTextAlignment(.trailing)
                .font(.system(size: 17))
                .padding()
        }
    }
}

//#Preview {
//    RefriAddFoodView()
//        .environment(NavigationManager())
//}
