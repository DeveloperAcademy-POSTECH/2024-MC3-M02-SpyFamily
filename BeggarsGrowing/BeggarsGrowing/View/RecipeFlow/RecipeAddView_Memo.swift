//
//  RecipeAddView_Memo.swift
//  BeggarsGrowing
//
//  Created by 박하연 on 7/30/24.
//

import SwiftUI
struct RecipeAddView_Memo: View {
    @State private var memo = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 255/255, green: 250/255, blue: 233/255)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Divider()
                        .foregroundColor(.black)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .padding(.bottom, 20)
// // // // //
                    HStack(spacing: 0) {
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(red: 242/255, green: 245/255, blue: 240/255))
                            .overlay(Text("1")
                                .foregroundColor(.black))
                            .padding(.trailing, 10)
                            .padding(.leading, 16)
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(red: 242/255, green: 245/255, blue: 240/255))
                            .overlay(Text("2")
                                .foregroundColor(.black))
                            .padding(.trailing, 10)
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(red: 242/255, green: 245/255, blue: 240/255))
                            .overlay(Text("3")
                                .foregroundColor(.black))
                            .padding(.trailing, 10)
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(red: 242/255, green: 245/255, blue: 240/255))
                            .overlay(Text("4")
                                .foregroundColor(.black))
                            .padding(.trailing, 10)
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(red: 246/255, green: 153/255, blue: 39/255))
                            .overlay(Text("5")
                                .foregroundColor(.white))
                            .padding(.trailing, 10)
                        Spacer()
                    }
                    .padding(.bottom, 44)
// // // // //
                        VStack(spacing: 12) {
                            HStack(spacing: 0) {
                                Text("메모")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Text("를")
                                Spacer()
                            }
                            HStack {
                                Text("입력해주세요.")
                                Spacer()
                            }
                            .padding(.bottom, 20)
                        }
                        .font(.title)
                        .padding(.leading)
                    
                    VStack(spacing: 0) {
                     RoundedRectangle(cornerRadius: 8)
                            .frame(width: 340, height: 190)
                            .foregroundColor(Color(red : 242 / 255, green : 245 / 255, blue : 240 / 255))
                            .overlay(
                                Button(action: {}, label: {
                                    VStack{
                                        TextField("추가로 입력하고 싶은 내용을 적어주세요.", text: $memo)
                                            .padding(.bottom, 140)
                                            .padding(.trailing, 40)
                                    }
                                }))
                    }
                    Spacer()
                }
            }
            .navigationTitle("레시피 등록")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RecipeAddView_Memo()
}

