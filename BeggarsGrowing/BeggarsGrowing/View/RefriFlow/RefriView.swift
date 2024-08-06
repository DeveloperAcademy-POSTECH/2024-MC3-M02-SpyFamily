//
//  RefriView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI
import SwiftData


struct RefriView: View {
    @Environment(NavigationManager.self) var navigationManager
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var viewModel: CookViewModel
    
    @Query var foodsInRefri : [Refrigerator]
    @Query var recipeData : [Recipe]
    @Query var filterRecipes : [FilterRecipe]

    // 세그먼트 컨트롤
    @State private var selectedTab = 0
    let tabOptions = ["냉장", "냉동"]
    
    // 냉장 냉동 분류
    var filteredFoods: [Refrigerator] {
        return foodsInRefri.filter { $0.freezing == (selectedTab == 1) }
    }
    
    var body: some View {
        
        ZStack {
            Color(red: 255/255, green: 250/255, blue: 233/255)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0){
                Divider()
                    .frame(minHeight: 1)
                    .background(Color.black)
                    .padding(.top, 1)
                    .padding(.bottom, 12)
                
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
                .padding(.bottom, 14)
                
                
                // 냉장고가 비었을 때 보여주는 UI
                if filteredFoods.isEmpty {
                    Spacer()
                    Image("EmptyRefri")
                        .resizable()
                        .frame(width: 60,height: 121)
                    Text("냉장고가 텅 비었어요!").font(.body).fontWeight(.regular)
                        .padding(.top, 16)
                }
                else{
                    // 냉장고 재료 리스트
                    ScrollView {
                        VStack(spacing: 0){
                            ForEach(filteredFoods) { food in
                                FoodCard(foodInRefri: food)
                            }
                            .padding(.vertical, 10)
                            
                            
                        }
                    }
                }
                
                Spacer()
                Button(action: {
                    // 식재료 추가하기 동작
                    navigationManager.push(to: .refriAddFood)
                }) {
                    Image("RefriViewButton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 0, leading: 46, bottom: 0, trailing: 46))
                }
                .padding(.bottom, 54)
            }
            .padding(.horizontal, 16)
            .navigationDestination(for: PathType.self) { pathType in
                pathType.NavigatingView()
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("냉장고")
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    navigationManager.pop()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
            }
        }
        .onChange(of:foodsInRefri){
            DispatchQueue.main.async{
                viewModel.foodsInRefri = foodsInRefri
                viewModel.recipeData = recipeData
                viewModel.recipeIdsforFilter = filterRecipes
                viewModel.checkRefriFoodsInRecipe()
            }
        }
    }
}

struct FoodCard: View {
    var foodInRefri: Refrigerator
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var viewModel: CookViewModel
    
    @State var showingDeleteAlert = false
    
    let foodImageName = FoodImageName()
    
    var body: some View {
        ZStack {
            // 배경 이미지
            Image("FoodBackground")
                .resizable()
                .aspectRatio(contentMode: .fit)
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.customBrown, lineWidth: 2)
                        .frame(width: 76, height: 76)
                    if let foodImage = foodImageName.getImageName(for: foodInRefri.food) {
                        Image(foodImage)
                            .resizable()
                            .frame(width: 68, height: 68)
                    } else{
                        
                    }
                }.padding(EdgeInsets(top: 16, leading: 7, bottom: 16, trailing: 12))
                
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(foodInRefri.food)
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.trailing, 10)
                        Text("D+\(daysSinceToday(addDay: foodInRefri.date))")
                            .font(.callout)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(Color.customBrown)
                            .foregroundColor(.white)
                            .cornerRadius(13.5)
                    }.padding(.bottom, 8)
                    
                    Text("\(foodInRefri.price)원 / 남은 양 \(Int(foodInRefri.amount))%")
                        .font(.subheadline)
                }
                
                Spacer()
                
                Button(action: {
                    showingDeleteAlert=true
                    //                    modelContext.delete(foodInRefri)
                }) {
                    ZStack{
                        Image("trash")
                            .resizable()
                            .frame(width: 20, height: 22)
                    }.frame(width: 50,height: 50)
                }
                .padding(.trailing, 8)
                .alert(isPresented: $showingDeleteAlert){
                    Alert(title: Text("\(foodInRefri.food)를 삭제하시겠습니까?"),
                          primaryButton: .destructive(Text("삭제"), action: {
                        DispatchQueue.main.async{
                            modelContext.delete(foodInRefri)
                        }
                    }),
                          secondaryButton: .cancel(Text("취소"))
                    )
                }
            }
        }
        .cornerRadius(4)
        .shadow(radius: 2)
    }
}


// D+day 계산하는 함수
func daysSinceToday(addDay: Date) -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day], from: addDay, to: Date())
    return components.day ?? 0
}

// 날짜를 형식에 맞게 변환하는 함수
func formattedDate(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
}
