//
//  BeggarsHOFView.swift
//  BeggarsGrowing
//
//  Created by 이예형 on 8/2/24.
//
import SwiftUI
import SwiftData

struct BeggarsHOFView: View {
    @Environment(NavigationManager.self) var navigationManager
    @EnvironmentObject var mainViewModel: MainViewModel
    
    @AppStorage("StoryStage") var storyStage: Int = 0

    @Query var beggars: [Beggars]

    let beggarsList = BeggarsList()
    @State var totalSavedMoney : Int = 0
    
    var body: some View {
        ZStack {
            Color(red: 255/255, green: 250/255, blue: 233/255)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Divider()
                    .frame(minHeight: 1)
                    .background(Color.black)
                    .padding(.top, 1)
                    .padding(.bottom, 19)
                
                HStack{
                    Spacer()
                    Image("Coin")
                        .resizable()
                        .frame(width: 38,height: 24)
                    Text("\(totalSavedMoney)")
                        .font(.DGMTitle3)
                }.padding(.horizontal,16)
                    .padding(.bottom,12)
                
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                        // Locked items
                        ForEach(beggarsList.beggars.indices, id: \.self) { index in
                            let beggar = beggarsList.beggars[index]
                            if index <= storyStage{
                                Image(beggar.image)
                                    .resizable()
                                    .frame(maxWidth: 110, maxHeight: 153)
                                    .aspectRatio(contentMode: .fit)
                                    .shadow(color: .black.opacity(0.25), radius: 1.61053, x: 0, y: 3.22105)
                            }
                            else{
                                Image("LockedItem")
                                    .resizable()
                                    .frame(maxWidth: 110, maxHeight: 153)
                                    .aspectRatio(contentMode: .fit)
                                    .shadow(color: .black.opacity(0.25), radius: 1.61053, x: 0, y: 3.22105)
                            }
                        }
                        
                    }
                    .padding(.horizontal,16)
                }
            }
        }
        .onAppear{
            let nowMoneyList = beggars.map{$0.nowMoney}
            totalSavedMoney = nowMoneyList.reduce(0, +)
        }
        .navigationDestination(for: PathType.self) { pathType in
            pathType.NavigatingView()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("거지의 전당")
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
    }
}
