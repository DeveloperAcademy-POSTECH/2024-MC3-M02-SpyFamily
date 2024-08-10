///
//  MainView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/20/24.
//


import SwiftUI
import SwiftData

struct MainView: View {
    @AppStorage("StoryStage") var storyStage: Int = 0
    @AppStorage("MoneyFoRSave") var moneyForSave: Int = 0
    
    @Environment(NavigationManager.self) var navigationManager
    
    @EnvironmentObject var viewModel: CookViewModel
    @EnvironmentObject var mainViewModel: MainViewModel
    @Environment(\.modelContext) private var modelContext
    
    @State var receivedHistory: History?
    @State var shouldNavigate = false
    @State var showOverlay = false
    @State var showStoryOverlay = false
    @State var animationToggle = false
    @State var moneyTobeChanged = 0
    
    @State private var isAnimating = false
    @Namespace private var animationNamespace
    
    @State private var progressValue: Float = 25000
    @State private var maxValue: Float = 20000
    
    @Query var histories: [History]
    @Query var beggars: [Beggars]
    @Query var foodsInRefri: [Refrigerator]
    
    var body: some View {
        
        VStack {

            // 커스텀 프로그레스 바
            CustomProgressBar(value: Float(mainViewModel.nowBeggar.nowMoney), maxValue: Float(mainViewModel.nowBeggar.goalMoney))
                .frame(height: 40)
                .padding(EdgeInsets(top: 30, leading: 27, bottom: 30, trailing: 27))
                .onChange(of:animationToggle){
                    print("onchange animationToggle")
                    if animationToggle == true{
                        print("if animationToggle true")
                        successAnimation()
                    }
                }
            
            // 첫번째 줄 버튼 두개
            HStack{
                Button(action: {
                    navigationManager.push(to:.beggarsHOF)
                }) {
                    Image("MainBeggarHOF")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 77)
                }
                
                Spacer()
                
                Button(action: {
                    navigationManager.push(to:.refri)
                }) {
                    Image("MainRefriButton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 77)
                }
            }.padding(.horizontal, 13)
            
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
            
            Button(action: {
                withAnimation(.spring()) {
                    isAnimating.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showStoryOverlay = true
                    }
                }            }) {
                    Image(mainViewModel.nowBeggar.image)
                        .resizable()
                        .frame(maxWidth: 190,maxHeight: 286)
                        .scaledToFit()
                        .scaleEffect(isAnimating ? 1.1 : 1.0)
                        .matchedGeometryEffect(id: "image", in: animationNamespace)
                }
            
            // Text Box
            ZStack(alignment: .top) {
                Image("MainDialog")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 330, height: 94)
                
                VStack {
                    HStack {
                        Text(mainViewModel.nowBeggar.name)
                            .multilineTextAlignment(.center)
                            .font(.DGMFootnote)
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
                    
                    Text(BeggarsList().beggars[storyStage].ment.randomElement() ?? "")
                        .font(.DGMFootnote)
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
                viewModel.reset()
                navigationManager.push(to:.cookChoiceFood)
            }) {
                Image("MainCookButton")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 230, maxHeight: 70)
            }
            .padding(.bottom, 50)
        }
        .overlay{
            if showOverlay {
                ResultPriceOverlay(historyToShow: receivedHistory ?? History(menu: "", foods: [""], foodsPrice: [0], menuPrice: 0, savedMoney: 0, date: Date()), showOverlay: $showOverlay)
                    .transition(.opacity)
            }
            if showStoryOverlay {
                StoryOverlay(showStoryOverlay: $showStoryOverlay, isAnimating: $isAnimating, animationNamespace: animationNamespace)
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        // 배경 이미지
        .background(Image("MainBG\(storyStage)")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all))
        .navigationDestination(for: PathType.self) { pathType in
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
            mainViewModel.beggars = beggars
            DispatchQueue.main.async{
                mainViewModel.nowBeggar = beggars.filter {$0.stage == storyStage}[0]
                if moneyForSave != 0{
                    checkSaveMoney()
                }
            }
        }
        .onChange(of:showOverlay) {
            print(".Onchange showOVerlay")
            if showOverlay == false{
                print("if showOverlay = false")
                checkSaveMoney()
                for usedFood in viewModel.foodsUsage {
                    if let index = foodsInRefri.firstIndex(where: { $0.id == usedFood.0.id }) {
                        foodsInRefri[index].amount -= usedFood.1 * 100
                        if foodsInRefri[index].amount <= 0 {
                            DispatchQueue.main.async{
                                foodsInRefri[index].amount = 0
                                modelContext.delete(foodsInRefri[index])
                            }
                        }
                    }
                }
            }
        }
    }
    
    func successAnimation() {
        print("successAnimation Start")
        DispatchQueue.main.async{
            withAnimation(Animation.easeInOut(duration: 3.0)) {
                print(moneyTobeChanged)
                mainViewModel.nowBeggar.nowMoney = self.moneyTobeChanged
                print("nowMoney = moneyTobeChanged")
            }
            
            if mainViewModel.nowBeggar.nowMoney == mainViewModel.nowBeggar.goalMoney{
                print("nowMoney == goalMoney")
                if BeggarsList().beggars.count > storyStage {
                    storyStage += 1
                    let newBeggar = BeggarsList().beggars[storyStage]
                    modelContext.insert(Beggars(stage: storyStage, name: newBeggar.name, image: newBeggar.image, goalMoney: newBeggar.goalMoney, nowMoney: 0))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                        navigationManager.push(to:.beggarsHOF)
                        
                    }
                }
            }
        }
        animationToggle = false
    }
    func checkSaveMoney() {
        print(moneyForSave)
        mainViewModel.moneyForSave = moneyForSave
        moneyTobeChanged = mainViewModel.giveMoneyToBeggars()
        self.moneyForSave = mainViewModel.moneyForSave
        print(moneyTobeChanged)
        animationToggle = true
        print("animationToggle = true")
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
            Text("\(formattedAmount(Int(value))) / \(formattedAmount(Int(maxValue)))")
                .font(.DGMTitle3)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
        )
    }
}

func formattedAmount(_ amount: Int) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.groupingSeparator = ""
    return numberFormatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
}
