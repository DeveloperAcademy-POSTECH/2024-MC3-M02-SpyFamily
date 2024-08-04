//
//  CookRecordView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI
import SwiftData

struct CookRecordView: View {
    @Environment(NavigationManager.self) var navigationManager
    @EnvironmentObject var viewModel: CookViewModel
    @Environment(\.modelContext) private var modelContext
    
    @State private var showImagePicker = false
    
    @State var showingSelectFoodSheet: Bool = false
    @State var selectedFoodsList: [Refrigerator] = []
    @Query var foodsInRefri: [Refrigerator]
    
    var imageName = FoodImageName()
    
    var body: some View {
        ZStack {
            VStack{
                // 이미지 등록 뷰
                Button(action: {
                    navigationManager.push(to: .cookRecordCamera)
                }) {
                    if let selectedImage = viewModel.recentImage {
                        Image(uiImage: selectedImage)
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
                        selectedFoodsList = viewModel.usedFoods.map { $0.0 }
                        showingSelectFoodSheet.toggle()
                    }) {
                        Image("AddButton")
                            .resizable()
                            .frame(maxWidth: 24,maxHeight: 24)
                    }
                }.padding(.vertical,20)
                
                // 재료 사용량 리스트
                ScrollView{
                    if viewModel.usedFoods.count > 0 {
                        ForEach(viewModel.usedFoods.indices, id: \.self) { index in
                            let food = viewModel.usedFoods[index].0
                            let foodName = food.food
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .frame(width: 60, height: 60)
                                        .foregroundStyle(Color(red: 0.99, green: 0.94, blue: 0.82))
                                    Image(imageName.getImageName(for: foodName) ?? "")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color(red: 152/255, green: 76/255, blue: 60/255), lineWidth: 2)
                                        )
                                }
                                
                                Text(foodName)
                                    .font(.body)
                                    .padding(.leading, 16)
                                
                                Spacer()
                                Text("\(Int(food.amount-viewModel.usedFoods[index].1))%")
                                Spacer()
                                
                                VStack {
                                    // 슬라이더 값을 표시하는 텍스트
                                    Text("\(Int(viewModel.usedFoods[index].1))")
                                        .font(.caption2)
                                        .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
                                        .background(Color.black)
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                                        .offset(x: thumbOffset(in: 135, index:index), y: 5) // 슬라이더 너비로 변경
                                    
                                    ZStack {
                                        // 눈금 표시
                                        HStack(spacing: (120) / 10) { // 슬라이더 너비로 변경
                                            ForEach(0..<11) { index in
                                                Circle()
                                                    .fill(Color.gray)
                                                    .frame(width: 3, height: 3)
                                            }
                                        }
                                        .padding(.horizontal, 16)
                                        
                                        // 기본 슬라이더
                                        Slider(value: $viewModel.usedFoods[index].1, in: 0...100, step: 10)
                                            .padding(.horizontal, 16)
                                            .frame(width: 190) // 슬라이더 너비로 변경
                                            .accentColor(.orange)
                                    }
                                    
                                    // 슬라이더 범위 표시
                                    HStack(alignment:.center) {
                                        Text("0").font(.caption2)
                                        Spacer()
                                        Text("50").font(.caption2)
                                            .padding(.leading,10)
                                        Spacer()
                                        Text("100").font(.caption2)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, -10)
                                    
                                }
                                .frame(width: 190, height: 50) // 슬라이더 너비로 변경
                            }
                            .padding(2)
                            .onAppear{
                            }
                        }
                    }
                }
                
                
                if viewModel.recentImage != nil {
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
                        DispatchQueue.main.async{
                            let newHistory = viewModel.finishCookRecord()
                            modelContext.insert(newHistory)
                            NotificationCenter.default.post(name: .finishCookRecordNotification, object: newHistory)
                        }
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
        .sheet(isPresented: $showingSelectFoodSheet,
               onDismiss: {
            viewModel.usedFoods = selectedFoodsList.map{ ($0, 0) }
        },
               content: {
            CookSelectFoodSheetView(selectedFoodsList: $selectedFoodsList, foodsInRefri: foodsInRefri)
                .presentationDetents([.fraction(0.75)]) // 시트 높이를 3/4로 설정
        })
        
        .background(Color(red: 1, green: 0.98, blue: 0.91))
        .navigationTitle("요리 등록")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
    }
    
    // 슬라이더의 썸(Thumb) 위치 계산 함수
    private func thumbOffset(in totalWidth: CGFloat, index:Int) -> CGFloat {
        let sliderWidth = totalWidth - 18 // 썸 크기를 고려한 너비 (썸의 크기를 대략적으로 30으로 가정)
        let thumbPosition = sliderWidth * CGFloat(viewModel.usedFoods[index].1 / 100)
        return thumbPosition - (totalWidth / 2)
    }
}

extension Notification.Name {
    static let finishCookRecordNotification = Notification.Name("finishCookRecordNotification")
}
