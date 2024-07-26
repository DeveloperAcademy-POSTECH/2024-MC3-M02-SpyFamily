//
//  CookRecordView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI


struct CookRecordView: View {
    @State private var ingredientAmounts = [0.4, 0.45] // dummy 데이터
    @State private var showImagePicker = false
    @State private var selectedImage: Image? = nil
    
    var body: some View {
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
                        
                        Text("요리 사진을 찍어주세요!")
                            .font(.footnote)
                            .foregroundStyle(Color.gray)
                    }
                    .frame(width: 320, height: 190)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                }
            }
            
            // 재료 사용량 타이틀
            HStack{
                Text("재료를 얼마나 사용하셨나요?")
                    .font(.title3)
                Spacer()
            }.padding(.vertical,20)
            
            // 재료 사용량 리스트
            ForEach(ingredientAmounts.indices, id: \.self) { index in
                HStack {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 60, height: 60)
                            .foregroundStyle(Color(red: 0.99, green: 0.94, blue: 0.82))
                        Image("carrot") // 여기에 실제 이미지 이름을 넣으세요
                            .resizable()
                            .frame(width: 60, height: 60)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color(red: 152/255, green: 76/255, blue: 60/255), lineWidth: 2)
                        )
                    }
                    
                    Text("재료명")
                        .font(.body)
                        .padding(.leading, 16)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            if ingredientAmounts[index] > 0 {
                                ingredientAmounts[index] -= 0.05
                            }
                        }) {
                            Text("−")
                                .font(.title)
                                .frame(width: 40, height: 40)
                                .background(Color.yellow)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                        }
                        
                        Text("\(Int(ingredientAmounts[index] * 100))%")
                            .font(.headline)
                            .frame(width: 50)
                        
                        Button(action: {
                            if ingredientAmounts[index] < 1 {
                                ingredientAmounts[index] += 0.05
                            }
                        }) {
                            Text("+")
                                .font(.title)
                                .frame(width: 40, height: 40)
                                .background(Color.yellow)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                        }
                        
                    }
                }
            }
            
            // 재료 추가 버튼
            Button(action: {
                ingredientAmounts.append(0.0)
            }) {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Circle().fill(Color.green))
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 1)
                    )
            }
            
            Spacer()
            
            // 완료 버튼
            Button(action: {
                // 완료 액션 추가
            }) {
                Text("완료")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(width: 300, height: 60)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    )
            }
        }
        .padding()
        .sheet(isPresented: $showImagePicker) {
            // ImagePickerView() // 이미지 선택 뷰 추가 필요
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
