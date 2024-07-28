//
//  CookRecipeDetailView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//

import SwiftUI

struct CookRecipeDetailView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    @State private var RecipeName: String = "돼지고기 김치찌개"
    @State private var Link: String = "맛있는 김치찌개 만들기ㅣ백종원의 요리비책 가나다라마바사"
    @State private var Foodicon: String = "carrot"
    @State private var FoodName: [String] = [
        "돼지고기",
        "배추김치",
        "양파",
        "다진마늘"
    ]
    @State private var FoodAmount: [String] = [
        "600g",
        "100g",
        "1알",
        "2스푼"
    ]
    @State private var SauceName: [String] = [
        "간장",
        "소금",
        "설탕"
    ]
    @State private var SauceAmount: [String] = [
        "1스푼",
        "2꼬집",
        "10g"
    ]
    @State private var Memo: String = "며느리에게도 알려주지 않는 비법소스"

    var body: some View {
        ZStack{
            Color(red: 255 / 255, green: 250 / 255, blue: 233 / 255)
                .ignoresSafeArea()
            ScrollView{
                VStack(spacing: 0){
                    Rectangle() //레시피 이미지
                        .foregroundColor(.gray)
                        .frame(height: 233)
                        .padding(.bottom, 12)
                    VStack(alignment: .leading, spacing: 0){
                        HStack{
                            Text(RecipeName)
                                .font(.system(size: 28))
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        .padding(.bottom, 15)
                        Text("요리 레시피 링크")
                            .font(.system(size: 17))
                            .fontWeight(.heavy)
                            .padding(.bottom, 10)
                        HStack(spacing: 0){
                            Image(systemName: "link")
                                .foregroundColor(.blue)
                                .bold()
                                .padding(.trailing, 5)
                            Text(Link)
                                .foregroundColor(.blue)
                                .underline()
                                .lineLimit(1)
                                .truncationMode(.tail) //넘치는 텍스트 말줄임표 표시
                        }
                        .padding(.bottom, 15)
                        Text("재료")
                            .font(.system(size: 17))
                            .fontWeight(.heavy)
                            .padding(.bottom, 6)
                        
                        Divider()
                            .frame(minHeight: 1)
                            .background(Color.black)
                            .padding(.bottom, 4)
                        ForEach(Array(FoodName.enumerated()), id: \.offset) { index, FoodName in
                            HStack(spacing: 0){
                                Image(Foodicon)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(.trailing, 10)
                                Text(FoodName)
                                    .font(.system(size: 17))
                                Spacer()
                                Text(FoodAmount[index])
                                    .font(.system(size: 17))
                            }
                            .padding(.vertical, 14)
                            .padding(.leading, 10)
                            .padding(.trailing, 20)
                        }
                        Text("소스")
                            .font(.system(size: 17))
                            .fontWeight(.heavy)
                            .padding(.top, 16)
                            .padding(.bottom, 6)
                        Divider()
                            .frame(minHeight: 1)
                            .background(Color.black)
                            .padding(.bottom, 8)

                        ForEach(Array(SauceName.enumerated()), id: \.offset) { index, SauceName in
                            HStack(spacing: 0){
                                Text(SauceName)
                                    .font(.system(size: 17))
                                Spacer()
                                Text(SauceAmount[index])
                                    .font(.system(size: 17))
                            }
                            .padding(.vertical, 14)
                            .padding(.leading, 10)
                            .padding(.trailing, 20)
                        }
                        
                        Text("메모")
                            .font(.system(size: 17))
                            .fontWeight(.heavy)
                            .padding(.top, 18)
                            .padding(.bottom, 8)

                        
                        Divider()
                            .frame(minHeight: 1)
                            .background(Color.black)
                            .padding(.bottom, 8)
                        ZStack(alignment: .topLeading){
                            RoundedRectangle(cornerRadius: 6)
                                .frame(height: 200)
                                .foregroundColor(Color(red: 252 / 255, green: 239 / 255, blue: 209 / 255))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.gray, lineWidth: 1))
                            Text(Memo)
                                .padding(10)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 50)
                    
                    Button(action: {
                        navigationManager.push(to: .cookRecord)
                    }, label: {
                        Image("RecordPhoto")
                    })
                    .padding(.bottom, 66)
                    .navigationDestination(for: PathType.self) { pathType in
                        pathType.NavigatingView()
                    }
                    
                }
            }
        }
    }
}

#Preview {
    CookRecipeDetailView()
        .environment(NavigationManager())
}
