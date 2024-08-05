//
//  RecipeAddView_Memo.swift
//  BeggarsGrowing
//
//  Created by 이예형 on 7/31/24.
//

import SwiftUI
struct RecipeAddView_Memo: View {
    @Environment(NavigationManager.self) var navigationManager
    @EnvironmentObject var viewModel: RecipeViewModel
    @Environment(\.modelContext) private var modelContext

    @State private var memo = ""
    @State private var isAlertPresented = false
    
    var body: some View {
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
                    Button(action:{
                        DispatchQueue.main.async{
                            viewModel.inputMemo = memo
                            modelContext.insert(viewModel.finishRecipeRecord())
                            navigationManager.pop(to: .recipe)
                        }
                    }, label:{
                        Text("입력 완료")
                    })
                }
                Spacer()
            }
        }
        .onAppear{
            memo = viewModel.inputMemo
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

#Preview {
    RecipeAddView_Memo()
}
