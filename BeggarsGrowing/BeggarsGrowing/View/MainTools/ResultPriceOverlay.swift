//
//  ResultPriceOverlay.swift
//  BeggarsGrowing
//
//  Created by 이예형 on 7/27/24.
//

import SwiftUI

struct ResultPriceOverlay: View {
    @AppStorage("MoneyFoRSave") var moneyForSave: Int = 0
    
    var historyToShow: History
    @Binding var showOverlay: Bool
    @EnvironmentObject var mainViewModel: MainViewModel
    
    // 애니메이션을 위한 변수
    @State private var animationCurrentIndex: Int = 0
    
    @State private var detailListOfUsedFoods: Bool = false
    
    var body: some View {
        ZStack {
            Image("MainResultOverlay")
                .resizable()
                .frame(width: 343, height: 500)
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
            
            VStack(spacing: 20) {
                Text("추정 소요금액")
                    .font(.DGMTitle2)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                VStack(spacing:15){
                    HStack{
                        Text("외식 평균")
                            .frame(width:100)
                            .font(.DGMTitle3)
                        Spacer()
                        Text("13,000")
                            .font(.custom("DungGeunMo", size: 25))
                    }
                    HStack{
                        Text("요리 비용")
                            .frame(width:100)
                            .font(.DGMTitle3)
                        Spacer()
                        Button(action:{
                            detailListOfUsedFoods.toggle()
                        }, label:{
                            Image(systemName: "magnifyingglass.circle.fill")
                                .resizable()
                                .frame(width:20, height:20)
                        })
                        Text("\(historyToShow.menuPrice)")
                            .font(.custom("DungGeunMo", size: 25))
                    }
                    if detailListOfUsedFoods{
                        if animationCurrentIndex > 3 {
                            ScrollView{
                                VStack{
                                    ForEach(0..<animationCurrentIndex, id: \.self) { index in
                                        if historyToShow.foodsPrice[index] != 0{
                                            HStack{
                                                Text(historyToShow.foods[index])
                                                Spacer()
                                                Text("\(historyToShow.foodsPrice[index])")
                                            }.font(.DGMBody)
                                                .frame(width:150)
                                        }
                                    }
                                }
                            }.frame(height:100)
                        } else{
                            ForEach(0..<animationCurrentIndex, id: \.self) { index in
                                if historyToShow.foodsPrice[index] != 0{
                                    HStack{
                                        Text(historyToShow.foods[index])
                                        Spacer()
                                        Text("\(historyToShow.foodsPrice[index])")
                                    }.font(.DGMBody)
                                        .frame(width:150)
                                }
                            }
                        }
                    }
                    HStack{
                        Text("아낀 금액")
                            .frame(width:100)
                            .font(.DGMTitle3)
                        Spacer()
                        Text("\(historyToShow.savedMoney)")
                            .font(.custom("DungGeunMo", size: 35))
                    }
                }.frame(width:225)
                
                Button(action: {
                    DispatchQueue.main.async{
                        moneyForSave = historyToShow.savedMoney
                        showOverlay = false
                    }
                }) {
                    Image("OverlayButton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 220, minHeight: 60)
                }
                .padding(.bottom, 20)
            }
            .onAppear {
                showItemsWithDelay()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
        .edgesIgnoringSafeArea(.all)
    }
    
    func showItemsWithDelay() {
        for index in 0..<historyToShow.foods.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.5) {
                withAnimation {
                    animationCurrentIndex = index + 1
                }
            }
        }
    }
}

