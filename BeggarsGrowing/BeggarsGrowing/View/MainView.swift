//
//  MainView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//


import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(NavigationManager.self) var navigationManager
    
    @EnvironmentObject var viewModel: CookViewModel
    @Environment(\.modelContext) private var modelContext
    
    @State var receivedHistory: History?
    @State var shouldNavigate = false
    @State var showOverlay = false
    
    @State private var progressValue: Float = 20000
    @State private var maxValue: Float = 20000
    
    @Query var histories: [History]
    
    var body: some View {
        ZStack{
            // 배경 색
            Color(red: 255/255, green: 250/255, blue: 233/255)
                .ignoresSafeArea()
            
            VStack {
                // 커스텀 프로그레스 바
                CustomProgressBar(value: progressValue, maxValue: maxValue)
                    .frame(height: 40)
                    .padding(EdgeInsets(top: 30, leading: 27, bottom: 30, trailing: 27))
                
                
                // 첫번째 줄 버튼 두개
                HStack{
                    Button(action: {
                        // 거지의전당 버튼 액션
                        navigationManager.push(to:.cookChoiceFood)
                    }) {
                        Image("MainBeggarCollection")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 77)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // 냉장고 버튼 액션
                        navigationManager.push(to:.refri)
                    }) {
                        Image("MainRefriButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 77)
                    }
                }.padding(.horizontal, 13)
                
                // 두번째 줄 버튼
                HStack{
                    Spacer()
                    
                    Button(action: {
                        // 레시피 버튼 액션
                        navigationManager.push(to:.recipe)
                    }) {
                        Image("MainRecipeButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 77)
                    }
                    
                }.padding(.horizontal, 13)
                
                Spacer()
                
                
                
                // Text Box
                ZStack(alignment: .top) {
                    Image("MainDialog")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 330, height: 94)
                    
                    VStack {
                        
                        HStack {
                            Text("미스탕후루씨")
                                .multilineTextAlignment(.center)
                                .fontWeight(.semibold)
                                .foregroundStyle(
                                    LinearGradient(
                                        stops: [
                                            Gradient.Stop(color: Color(red: 0.93, green: 0.8, blue: 0.25), location: 0.00),
                                            Gradient.Stop(color: Color(red: 0.93, green: 0.69, blue: 0.27), location: 1.00),
                                        ],
                                        startPoint: UnitPoint(x: 0.5, y: 0),
                                        endPoint: UnitPoint(x: 0.5, y: 1)
                                    )
                                )
                            Spacer()
                        }.padding(EdgeInsets(top: 15, leading: 18, bottom: 5, trailing: 0))
                        
                        Text("오늘은 마라탕을 먹고싶어... 나는 변준섭인데 귀찮지만 할거는 다해")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 30)
                            .padding(.top, -15)
                            .frame(width: 330,height: 44) // 너비를 330으로 제한하여 텍스트 줄바꿈
                    }
                    .frame(width: 330, height: 88)
                }
                .padding(.bottom, 20)
                
                
                // 요리하기 버튼
                Button(action: {
                    // 요리하기 버튼 액션
                    UINavigationBar.setAnimationsEnabled(false)
                    navigationManager.push(to:.cookChoiceFood)
                }) {
                    Image("MainCookButton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 230, maxHeight: 70)
                }
                .padding(.bottom, 50)
            }
            
            if showOverlay {
                ResultPriceOverlay(historyToShow: receivedHistory ?? History(menu: "", foods: [""], foodsPrice: [0], menuPrice: 0, savedMoney: 0, date: Date()))
                    .transition(.opacity)
                    .onTapGesture {
                        showOverlay = false
                    }
            }
        }.navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: .finishCookRecordNotification, object: nil, queue: .main) { notification in
                print("notification receive")
                if let history = notification.object as? History {
                    DispatchQueue.main.async{
                        self.receivedHistory = history
                        self.shouldNavigate = true
                        self.showOverlay = true
                    }
                }
            }
        }
    }
}
// 프로그레스바 커스텀
struct CustomProgressBar: View {
    var value: Float
    var maxValue: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // 프로그레스 바 배경
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color(red: 255/255, green: 250/255, blue: 233/255))
                    .frame(width: geometry.size.width, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.black, lineWidth: 2)
                    )
                
                // 프로그레스 바
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 1, green: 0.69, blue: 0.32), location: 0.00),
                                Gradient.Stop(color: Color(red: 0.97, green: 0.53, blue: 0.28), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
                    .frame(
                        width: min(CGFloat(self.value / self.maxValue) * (geometry.size.width - 12), geometry.size.width - 12),
                        height: 28
                    )
                    .padding(.horizontal, 6)
            }
        }
        .frame(height: 40)
        .overlay(
            Text("\(Int(value)) / \(Int(maxValue))")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
        )
    }
}
