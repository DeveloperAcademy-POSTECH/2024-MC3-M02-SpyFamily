//
//  CookChoiceFoodView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//
import SwiftUI

struct CookChoiceFoodView: View {
    @Environment(NavigationManager.self) var navigationManager
    @State private var showView = false
    
    @State var selectedTab: Int = 0
    @State var selectedFoods: [String: (Bool, String)] = [:]
    
    var Refrifood = ["당근", "달걀", "바게트"]
    var Freezefood = ["사과"]
    var amount = 40
    var date = 10
    
    var selectedFood: [String] {
        selectedFoods.filter { $0.value.0 }.map { $0.key }
    }
    
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
                    RefriView(foods: Refrifood, amount: Int(amount), date: Int(date), selectedFoods: $selectedFoods)
                } else {
                    FreezeView(foods: Freezefood, amount: Int(amount), date: Int(date), selectedFoods: $selectedFoods)
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
                            if food < selectedFood.count {
                                ZStack {
                                    Image(selectedFood[food])
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 43, height: 43)
                                        .clipped()
                                        .padding(.leading, 2)
                                        .padding(.horizontal, 7)
                                    
                                    if selectedFoods[selectedFood[food]]?.1 == "Freeze" {
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
                Button(action: {navigationManager.push(to: .cookChoiceRecipe)}, label: {
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
        //        .mask(
        //            Circle()
        //                .scale(showView ? 3 : 0.1) // 원의 크기 조절
        //                .animation(.easeInOut(duration: 0.5), value: showView) // 애니메이션 설정
        //                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // 화면 크기에 맞게 원 크기 설정
        //        )
        //        .opacity(showView ? 1 : 0)
        //        .animation(.easeInOut(duration: 0.5), value: showView)
        //        .navigationDestination(for: PathType.self) { pathType in
        //            pathType.NavigatingView()
        //        }
        //        .onAppear{
        //            showView = true
        //            UINavigationBar.setAnimationsEnabled(true)
        //        }
    }
    
    // // // 냉장 // // //
    struct RefriView: View {
        var foods: [String]
        var amount: Int
        var date: Int
        
        @Binding var selectedFoods: [String: (Bool, String)]
        
        var body: some View {
            VStack {
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
                                .opacity(selectedFoods[food]?.0 ?? false ? 1 : 0)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    toggleFoodSelection(for: food, source: "Refri")
                                }
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 152/255, green: 76/255, blue: 60/255), lineWidth: 2)
                                        .frame(width: 76, height: 76)
                                        .overlay(Image("\(food)"))
                                        .padding(.leading, 3)
                                    RoundedRectangle(cornerRadius: 13.5)
                                        .overlay(
                                            Text("D+\(date)")
                                                .foregroundColor(.white)
                                                .font(.system(size: 15))
                                        )
                                        .frame(width: 52, height: 20)
                                        .padding(.trailing, 28)
                                        .padding(.bottom, 68)
                                        .foregroundColor(Color(red: 152/255, green: 76/255, blue: 60/255))
                                }
                                
                                Text(food)
                                    .font(.title2)
                                    .fontWeight(.black)
                                
                                Spacer()
                                
                                Text("남은 양")
                                
                                VStack {
                                    Text("\(amount)%")
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
        
        private func toggleFoodSelection(for food: String, source: String) {
            if selectedFoods[food]?.0 == true {
                selectedFoods[food] = (false, source)
            } else {
                if selectedFoods.filter({ $0.value.0 }).count >= 3 {
                    return
                }
                selectedFoods[food] = (true, source)
            }
        }
    }
    
    // // // 냉동 // // //
    struct FreezeView: View {
        var foods: [String]
        var amount: Int
        var date: Int
        
        @Binding var selectedFoods: [String: (Bool, String)]
        
        var body: some View {
            VStack {
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
                                .opacity(selectedFoods[food]?.0 ?? false ? 1 : 0)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    toggleFoodSelection(for: food, source: "Freeze")
                                }
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 152/255, green: 76/255, blue: 60/255), lineWidth: 2)
                                        .frame(width: 76, height: 76)
                                        .overlay(Image("\(food)"))
                                        .padding(.leading, 3)
                                    RoundedRectangle(cornerRadius: 13.5)
                                        .overlay(
                                            Text("D+\(date)")
                                                .foregroundColor(.white)
                                                .font(.system(size: 15))
                                        )
                                        .frame(width: 52, height: 20)
                                        .padding(.trailing, 28)
                                        .padding(.bottom, 68)
                                        .foregroundColor(Color(red: 152/255, green: 76/255, blue: 60/255))
                                }
                                
                                Text(food)
                                    .font(.title2)
                                    .fontWeight(.black)
                                
                                Spacer()
                                
                                Text("남은 양")
                                
                                VStack {
                                    Text("\(amount)%")
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
        
        private func toggleFoodSelection(for food: String, source: String) {
            if selectedFoods[food]?.0 == true {
                selectedFoods[food] = (false, source)
            } else {
                if selectedFoods.filter({ $0.value.0 }).count >= 3 {
                    return
                }
                selectedFoods[food] = (true, source)
            }
        }
    }
}

