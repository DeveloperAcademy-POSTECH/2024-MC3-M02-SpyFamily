//
//  CookRecordView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI


struct UsedIngredient: Identifiable{
    var id = UUID()
    var image: Image
    var name: String
    var amount: Double
    var isCustom: Bool
}

struct CookRecordView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    @State private var showImagePicker = false
    @State private var selectedImage: Image? = nil
    
    @State private var usedIngredients = [UsedIngredient(image: Image(""), name: "양파", amount: 0.5, isCustom: false),UsedIngredient(image: Image(""), name: "당근", amount: 0.6, isCustom: false),UsedIngredient(image: Image(""), name: "닭고기", amount: 1, isCustom: false),UsedIngredient(image: Image(""), name: "청양고추", amount: 0.4, isCustom: false)]
    
    var body: some View {
        ZStack {
            VStack{
                // 이미지 등록 뷰
                Button(action: {
                    showImagePicker = true
                }) {
                    if let selectedImage = selectedImage {
                        selectedImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 230)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    } else {
                        VStack {
                            HStack(spacing: 5) {
                                Image(systemName: "camera")
                                    .font(.body)
                                Text("사진 등록")
                                    .font(.body)
                            }.foregroundStyle(Color.black)
                                .padding(.bottom, 5)
                            
                            Text("요리 사진을 찍어주세요!")
                                .font(.footnote)
                                .foregroundStyle(Color.gray)
                        }
                        .frame(width: 320, height: 190)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(red: 0.94, green: 0.94, blue: 0.94))
                            .stroke(Color.gray, lineWidth: 1))
                    }
                }
                
                // 재료 사용량 타이틀
                HStack{
                    Text("재료를 얼마나 사용하셨나요?")
                        .font(.title3)
                    Spacer()
                    
                    // 재료 추가 버튼
                    // 내 냉장고 재료들을 보여주는 시트가 올라오도록 변경해야 함.
                    Button(action: {
                        usedIngredients.append(UsedIngredient(image: Image(""), name: "추가 데이터", amount: 0, isCustom: true))
                    }) {
                        Image("AddButton")
                            .resizable()
                            .frame(maxWidth: 24,maxHeight: 24)
                    }
                }.padding(.vertical,20)
                
                // 재료 사용량 리스트
                ScrollView{
                    ForEach(usedIngredients.indices, id: \.self) { index in
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 60, height: 60)
                                    .foregroundStyle(Color(red: 0.99, green: 0.94, blue: 0.82))
                                usedIngredients[index].image // 실제 이미지 넣기
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color(red: 152/255, green: 76/255, blue: 60/255), lineWidth: 2)
                                    )
                            }
                            
                            Text(usedIngredients[index].name)
                                .font(.body)
                                .padding(.leading, 16)
                            
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    if usedIngredients[index].amount > 0 {
                                        usedIngredients[index].amount -= 0.05
                                    }
                                }) {
                                    Image("MinusStepper")
                                        .resizable()
                                        .frame(width: 40,height: 34)
                                }
                                
                                Text("\(Int(usedIngredients[index].amount * 100))%")
                                    .font(.body)
                                    .frame(width: 45)
                                
                                Button(action: {
                                    if usedIngredients[index].amount < 1 {
                                        usedIngredients[index].amount += 0.05
                                    }
                                }) {
                                    Image("PlusStepper")
                                        .resizable()
                                        .frame(width: 40,height: 34)
                                }
                                
                            }
                        }.padding(2)
                    }
                }
                
                
                if selectedImage == nil {
                    Text("사진을 등록하셔야 해요!")
                        .font(.footnote)
                        .padding(EdgeInsets(top: 6, leading: 30, bottom: 6, trailing: 30))
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color(red: 1, green: 0.93, blue: 0.83)))
                        .padding(.bottom,10)
                    
                    
                    Spacer()
                    
                    // 완료 버튼
                    Button(action: {
                        // 완료 액션 추가
                    }) {
                        Text("완료")
                            .font(.system(size: 20))
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: 300, minHeight: 60)  // 원하는 크기로 조정
                            .background(Color(red: 238/255, green: 238/255, blue: 238/255))
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color(red: 30/255, green: 66/255, blue: 66/255), lineWidth: 2)
                            )
                    }
                }
                else {
                    Button(action: {
                        // 완료 액션 추가
                        navigationManager.popToRoot()
                        navigationManager.push(to: .main)
                    }) {
                        Image("CookRecordViewButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(EdgeInsets(top: 0, leading: 46, bottom: 0, trailing: 46))
                    }
                }
            }
            .padding()
            .sheet(isPresented: $showImagePicker) {
                // ImagePickerView() // 이미지 선택 뷰 추가 필요
            }
        }
        .background(Color(red: 1, green: 0.98, blue: 0.91))
        .navigationTitle("요리 등록")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
    }
}

//struct CookRecordView: View {
//    @Environment(NavigationManager.self) var navigationManager
//
//    var body: some View {
//        VStack {
//            Text("CookRecordView")
//            Button("인증 완료") {
//                navigationManager.popToRoot()
//                navigationManager.push(to: .main)
//            }
//        }
//        .navigationDestination(for: PathType.self) { pathType in
//            pathType.NavigatingView()
//        }
//    }
//}

#Preview {
    CookRecordView()
        .environment(NavigationManager())
}
