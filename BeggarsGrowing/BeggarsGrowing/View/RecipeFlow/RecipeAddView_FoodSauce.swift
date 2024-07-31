//
//  RecipeAddView_FoodSauce.swift
//  BeggarsGrowing
//
//  Created by 이예형 on 7/31/24.
//

import SwiftUI

struct RecipeAddView_FoodSauce: View {
    @Environment(\.dismiss) var dismiss // 현재 뷰를 닫기 위한 dismiss 환경 변수 선언
    let numbers = [1, 2, 3, 4, 5]
    //    @State private var FoodIcon: String = "Carrot"
    @State private var FoodIcons: [String] = ["Carrot", "Carrot", "Carrot", "Carrot"]
    @State private var FoodNames: [String] = ["사과", "당근", "계란", "빵"]
    @State private var FoodQuantities: [String] = ["1개", "2개", "", ""]
    
    @State private var SauceNames: [String] = ["간장", "소금", "설탕", "고추장"]
    @State private var SauceQuantities: [String] = ["3개", "4개", "", ""]
    
    
    var body: some View {
        NavigationStack{
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
                            Image(systemName: "plus.rectangle.fill")
                                .resizable()
                                .frame(width: 32, height: 25)
                            .foregroundColor(Color(red: 246/255, green: 153/255, blue: 39/255))
                            .padding(.trailing, 4)
                        }
                        .padding(.bottom, 10)
                        Divider()
                            .frame(minHeight: 1)
                            .background(Color.black)
                            .padding(.bottom, 9)

                        ForEach(FoodNames.indices, id: \.self) { index in
                            HStack(spacing: 0){
                                Image(systemName: "minus.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 15)
                                Image(FoodIcons[index])
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .padding(.trailing, 7)
                                Text(FoodNames[index])
                                    .font(.system(size: 17))
                                    .fontWeight(.heavy)
                                Spacer()
                                TextField("용량과 단위", text: $FoodQuantities[index])
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
                            Image(systemName: "plus.rectangle.fill")
                                .resizable()
                                .frame(width: 32, height: 25)
                            .foregroundColor(Color(red: 246/255, green: 153/255, blue: 39/255))
                            .padding(.trailing, 4)
                        }
                        .padding(.bottom, 10)
                        .padding(.top, 45)

                        Divider()
                            .frame(minHeight: 1)
                            .background(Color.black)
                            .padding(.bottom, 9)
                        ForEach(FoodNames.indices, id: \.self) { index in
                            HStack(spacing: 0){
                                Image(systemName: "minus.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 20)
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
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("레시피 등록")
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: RecipeAddView_Memo()){
                    Text("다음")
                        .foregroundStyle(.black)
                }
            }
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

