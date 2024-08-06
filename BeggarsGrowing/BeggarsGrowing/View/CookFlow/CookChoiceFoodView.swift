//
//  CookChoiceFoodView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//
import SwiftUI
import SwiftData

struct CookChoiceFoodView: View {
    @Environment(NavigationManager.self) var navigationManager
    @EnvironmentObject var viewModel: CookViewModel
    
    @State private var showView = false
    @State var selectedTab: Int = 0
    @State var selectedFoods: [Refrigerator] = []
    @State private var isAlertPresented = false
    
    @Query var foodsInRefri : [Refrigerator]
    
    var freezingFoods: [Refrigerator] {
        foodsInRefri.filter { $0.freezing == true}
    }
    
    var notFreezingFoods: [Refrigerator] {
        foodsInRefri.filter { $0.freezing == false}
    }
    
    var imageName = FoodImageName()
    
    var body: some View {
        ZStack {
            Color(red: 255/255, green: 250/255, blue: 233/255)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                Divider()
                    .foregroundColor(.black)
                
                Picker("", selection: $selectedTab) {
                    Text("냉장").tag(0)
                    Text("냉동").tag(1)
                }
                .pickerStyle(.segmented)
                .frame(width: 118, height: 28)
                .padding(16)
                
                if selectedTab == 0 {
                        RefriView(foods: notFreezingFoods, selectedFoods: $selectedFoods)
                } else {
                        FreezeView(foods: freezingFoods, selectedFoods: $selectedFoods)
                }
                
                Divider()
                    .padding(.vertical, 10)
                Text("사용하고 싶은 재료를 골라주세요.")
                    .padding(.vertical, 12)
                    .padding(.top, 8)
                
                ZStack {
                    HStack(spacing: 0) {
                        ForEach(0..<3) { _ in
                            RoundedRectangle(cornerRadius: 4.5)
                                .foregroundColor(Color(red: 196/255, green: 142/255, blue: 104/255))
                                .overlay(RoundedRectangle(cornerRadius: 4.5)
                                    .stroke(Color(red: 152/255, green: 76/255, blue: 60/255), lineWidth: 2))
                                .frame(width: 50, height: 50)
                                .padding(.horizontal, 8)
                            
                        }}
                    .padding(.bottom, 20)
                    HStack {
                        ForEach(0..<3) { food in
                            if food < selectedFoods.count {
                                ZStack {
                                    Image(imageName.getImageName(for: selectedFoods[food].food) ?? "")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 43, height: 43)
                                        .clipped()
                                        .padding(.leading, 2)
                                        .padding(.horizontal, 7)
                                    
                                    if selectedFoods[food].freezing == true {
                                        Image(systemName: "snowflake")
                                            .foregroundColor(.white)
                                            .offset(x: -13, y: -15)
                                    }
                                }
                            } else {
                                RoundedRectangle(cornerRadius: 6)
                                    .frame(width: 43, height: 43)
                                    .padding(.horizontal, 8)
                                    .foregroundColor(Color.clear)
                            }
                        }
                    }
                    .padding(.bottom, 15)
                }
                
                // 선택한 재료를 토대로 레시피 추천
                Button(action: {
                    viewModel.selectedFoods = selectedFoods
                    navigationManager.push(to: .cookChoiceRecipe)
                }, label: {
                    Image("NextButton")
                        .padding(.bottom, 12)
                })
                
                // 재료 선택없이 레시피 추천
                Button(action: {navigationManager.push(to: .cookChoiceRecipe)}, label: {
                    Text("건너뛰기")
                        .underline()
                        .foregroundColor(.black)
                })
                Spacer()
            }
        }
        
        .navigationTitle("재료 선택")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(trailing: Button(action: {
            isAlertPresented.toggle()
        }) {
            Image(systemName: "xmark")
                .foregroundColor(.black)
        })
        .alert(isPresented: $isAlertPresented) {
            Alert(
                title: Text("경고"),
                message: Text("요리하기를 중단하시겠습니까?"),
                primaryButton: .destructive(Text("닫기")) {
                    navigationManager.pop(to: .main)
                },
                secondaryButton: .cancel(Text("취소"))
            )
        }

        // // // //
        .mask(
            Circle()
                .scale(showView ? 3 : 0.1) // 원의 크기 조절
                .animation(.easeInOut(duration: 0.5), value: showView) // 애니메이션 설정
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // 화면 크기에 맞게 원 크기 설정
        )
        .navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
        .onAppear{
            showView = true
            UINavigationBar.setAnimationsEnabled(true)
        }
    }
    
    // // // 냉장 // // //
    struct RefriView: View {
        var foods: [Refrigerator]
        
        @Binding var selectedFoods: [Refrigerator]
        var imageName = FoodImageName()
        
        var body: some View {
            VStack {
                if foods.isEmpty{
                    
                    Image("EmptyRefri")
                        .resizable()
                        .frame(width: 60,height: 121)
                        .padding(.top, 30)
                    Text("아직 재료가 추가되지 않았어요.\n먼저 냉장고에 재료를 추가해주세요.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    Spacer()
                    
                }
                else{
                    ScrollView {
                        ForEach(foods, id: \.self) { food in
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .opacity(0)
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 2)
                                        .opacity(0.15))
                                    .padding(.horizontal, 16)
                                    .padding(.top,1)
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color(red: 252/255, green: 239/255, blue: 209/255))
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(red: 152/255, green: 76/255, blue: 60/255), lineWidth: 2))
                                    .padding(.top, 1)
                                    .overlay(
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.orange)
                                            .padding(.leading, 320)
                                            .padding(.bottom, 50)
                                    )
                                    .frame(width: 361, height: 100)
                                    .opacity(selectedFoods.contains(food) ? 1 : 0)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        if selectedFoods.count >= 3 {
                                            if selectedFoods.contains(food) {
                                                selectedFoods.remove(at: selectedFoods.firstIndex(of:food) ?? 0)
                                            }
                                        } else {
                                            if selectedFoods.contains(food) {
                                                selectedFoods.remove(at: selectedFoods.firstIndex(of:food) ?? 0)
                                            } else {
                                                selectedFoods.append(food)
                                            }
                                        }
                                    }
                                HStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color(red: 152/255, green: 76/255, blue: 60/255), lineWidth: 2)
                                            .frame(width: 76, height: 76)
                                            .overlay{Image(imageName.getImageName(for: food.food) ?? "")
                                                    .resizable()
                                                .frame(width:68, height:68)}
                                            .padding(.leading, 3)
                                        RoundedRectangle(cornerRadius: 13.5)
                                            .overlay(
                                                Text("D+\(calculateDaysToToday(date1: food.date) ?? 0)")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 15))
                                            )
                                            .frame(width: 52, height: 20)
                                            .padding(.trailing, 28)
                                            .padding(.bottom, 68)
                                            .foregroundColor(Color(red: 152/255, green: 76/255, blue: 60/255))
                                    }
                                    
                                    Text(food.food)
                                        .font(.title2)
                                        .fontWeight(.black)
                                    
                                    Spacer()
                                    
                                    Text("남은 양")
                                    
                                    VStack {
                                        Text("\(Int(food.amount))%")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                    }
                                }
                                .padding(.horizontal, 25)
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
    
    // // // 냉동 // // //
    struct FreezeView: View {
        var foods: [Refrigerator]
        
        @Binding var selectedFoods: [Refrigerator]
        var imageName = FoodImageName()
        
        var body: some View {
            VStack {
                if foods.isEmpty{
                    
                    Image("EmptyRefri")
                        .resizable()
                        .frame(width: 60,height: 121)
                        .padding(.top, 30)
                    Text("아직 재료가 추가되지 않았어요.\n먼저 냉장고에 재료를 추가해주세요.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    Spacer()
                    
                }
                else{
                    ScrollView {
                        ForEach(foods, id: \.self) { food in
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .opacity(0)
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 2)
                                        .opacity(0.15))
                                    .padding(.horizontal, 16)
                                    .padding(.top,1)
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color(red: 252/255, green: 239/255, blue: 209/255))
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(red: 152/255, green: 76/255, blue: 60/255), lineWidth: 2))
                                    .padding(.top, 1)
                                    .overlay(
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.orange)
                                            .padding(.leading, 320)
                                            .padding(.bottom, 50)
                                    )
                                    .frame(width: 361, height: 100)
                                    .opacity(selectedFoods.contains(food) ? 1 : 0)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        if selectedFoods.count >= 3 {
                                            if selectedFoods.contains(food) {
                                                selectedFoods.remove(at: selectedFoods.firstIndex(of:food) ?? 0)
                                            }
                                        } else {
                                            if selectedFoods.contains(food) {
                                                selectedFoods.remove(at: selectedFoods.firstIndex(of:food) ?? 0)
                                            } else {
                                                selectedFoods.append(food)
                                            }
                                        }
                                    }
                                HStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color(red: 152/255, green: 76/255, blue: 60/255), lineWidth: 2)
                                            .frame(width: 76, height: 76)
                                            .overlay{Image(imageName.getImageName(for: food.food) ?? "")
                                                    .resizable()
                                                .frame(width:68, height:68)}
                                            .padding(.leading, 3)
                                        RoundedRectangle(cornerRadius: 13.5)
                                            .overlay(
                                                Text("D+\(calculateDaysToToday(date1: food.date) ?? 0)")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 15))
                                            )
                                            .frame(width: 52, height: 20)
                                            .padding(.trailing, 28)
                                            .padding(.bottom, 68)
                                            .foregroundColor(Color(red: 152/255, green: 76/255, blue: 60/255))
                                    }
                                    
                                    Text(food.food)
                                        .font(.title2)
                                        .fontWeight(.black)
                                    
                                    Spacer()
                                    
                                    Text("남은 양")
                                    
                                    VStack {
                                        Text("\(Int(food.amount))%")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                    }
                                }
                                .padding(.horizontal, 25)
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}


func calculateDaysToToday(date1: Date) -> Int? {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day], from: date1, to: Date())
    return components.day
}
