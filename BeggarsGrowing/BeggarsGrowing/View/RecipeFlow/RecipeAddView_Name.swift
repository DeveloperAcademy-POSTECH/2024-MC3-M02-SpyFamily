//
//  RecipeAddView_Name.swift
//  BeggarsGrowing
//
//  Created by 이예형 on 7/31/24.
//

import SwiftUI
struct RecipeAddView_Name: View {
    @State private var name = ""
    
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
                            .foregroundColor(Color(red: 246/255, green: 153/255, blue: 39/255))
                            .overlay(Text("1")
                                .foregroundColor(.white))
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
                            .foregroundColor(Color(red: 242/255, green: 245/255, blue: 240/255))
                            .overlay(Text("5")
                                .foregroundColor(.black))
                            .padding(.trailing, 10)
                        Spacer()
                    }
                    .padding(.bottom, 44)
// // // // //
                        VStack(spacing: 12) {
                            HStack(spacing: 0) {
                                Text("레시피명")
                                    .fontWeight(.bold)
                                Text("을")
                                Spacer()
                            }
                            HStack {
                                Text("입력해주세요.")
                                Spacer()
                            }
                            .padding(.bottom, 44)
                        }
                        .font(.title)
                        .padding(.leading)
                    
                    VStack {
                        HStack {
                            TextField("예) 김치찌개", text: $name)
                                .padding(.leading, 16)
                            Spacer()
                            Button(action: {
                                name = ""
                            }, label: {
                                Image(systemName: "xmark")
                                    .padding(.trailing, 16)
                                    .foregroundColor(.black)
                            })
                        }
                        Divider()
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .foregroundColor(.black)
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
    RecipeAddView_Name()
}