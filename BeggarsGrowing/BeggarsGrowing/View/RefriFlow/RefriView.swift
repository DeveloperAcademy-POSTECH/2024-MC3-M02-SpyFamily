//
//  RefriView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct TestFood: Identifiable{
    var id = UUID()
    var foodImage: Image
    var foodName: String
    var foodfreezing: Bool
    var foodDate: Int
    var foodPrice: Int
    var foodAmount: Double
}

// 더미데이터
let testFoods: [TestFood] = [TestFood(foodImage: Image(""), foodName: "당근", foodfreezing: false, foodDate: 2, foodPrice: 4000, foodAmount: 100),
                             TestFood(foodImage: Image(""), foodName: "계란", foodfreezing: false, foodDate: 1, foodPrice: 4000, foodAmount: 100),
                             TestFood(foodImage: Image(""), foodName: "빵", foodfreezing: true, foodDate: daysSinceToday(today: Date()), foodPrice: 4000, foodAmount: 100),
                             TestFood(foodImage: Image(""), foodName: "사과", foodfreezing: false, foodDate: 3, foodPrice: 4000, foodAmount: 100)]

struct RefriView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    // 세그먼트 컨트롤
    @State private var selectedTab = 0
    let tabOptions = ["냉장", "냉동"]
    
    // 냉장 냉동 분류
    var filteredFoods: [TestFood] {
        return testFoods.filter { $0.foodfreezing == (selectedTab == 1) }
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("냉장고")
                    .font(.title)
                    .padding(.top)
                // 세그먼티드 컨트롤
                Picker("Select a tab", selection: $selectedTab) {
                    ForEach(0..<tabOptions.count) { index in
                        Text(tabOptions[index])
                            .fontWeight(selectedTab == index ? .bold : .light)
                            .tag(index)
                            
                    }
                }
                .padding(2)
                .frame(width: 118, alignment: .center)
                .background(Color.brown)
                .cornerRadius(9)
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // 냉장고 재료 리스트
                ScrollView {
                    VStack {
                        ForEach(filteredFoods) { food in
                            FoodCard(food: food)
                                .padding(.bottom, 10)
                        }
                    }
                    .padding()
                }
                
                Button(action: {
                    // 식재료 추가하기 동작
                    navigationManager.push(to: .refriAddFood)
                }) {
                    Image("RefriViewButton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: .infinity)
                        .padding(EdgeInsets(top: 0, leading: 46, bottom: 0, trailing: 46))
                }
                .padding(.bottom)
            }        .navigationDestination(for: PathType.self) { pathType in
                pathType.NavigatingView()
        }
        }.background(Color(red: 1, green: 0.98, blue: 0.91))
    }
}

struct FoodCard: View {
    var food: TestFood
    
    var body: some View {
        ZStack {
            // 배경 이미지
            Image("FoodBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: .infinity)
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.customBrown, lineWidth: 2)
                        .frame(width: 76, height: 76)
                    Image("carrot")
                        .resizable()
                        .frame(width: 68, height: 68)
                }.padding(EdgeInsets(top: 16, leading: 7, bottom: 16, trailing: 12))
                
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(food.foodName)
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.trailing, 10)
                        Text("D+\(daysSinceToday(today: Date()))")
                            .font(.callout)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(Color.customBrown)
                            .foregroundColor(.white)
                            .cornerRadius(13.5)
                    }.padding(.bottom, 8)
                    
                    Text("\(food.foodPrice)원 / 남은 양 \(Int(food.foodAmount))%")
                        .font(.subheadline)
                }
                
                Spacer()
                
                Button(action: {
                    // 삭제 동작
                }) {
                    ZStack{
                        Image("trash")
                            .resizable()
                            .frame(width: 20, height: 22)
                    }.frame(width: 50,height: 50)
                    
                    
                }
                .padding(.trailing, 8)
            }
            .padding(.vertical, 1)
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(4)
        .shadow(radius: 2)
    }
}


// D+day 계산하는 함수
func daysSinceToday(today: Date) -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day], from: today, to: Date())
    return components.day ?? 0
}

// 날짜를 형식에 맞게 변환하는 함수
func formattedDate(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
}

#Preview {
    RefriView()
        .environment(NavigationManager())
}
