//
//  MainViewModel.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 8/4/24.
//


import SwiftUI
import SwiftData

class MainViewModel : ObservableObject {
    
    @AppStorage("StoryStage") var storyStage: Int = 0
    @AppStorage("MoneyFoRSave") var moneyForSave: Int = 0
    
    @Published var beggars: [Beggars] = []
    @Published var nowBeggar: Beggars = Beggars(stage: 0, name: "", image: "", goalMoney: 0, nowMoney: 0)
    
    func giveMoneyToBeggars() -> Int{
        
        var returnMoney = 0
        
        let nowBeggar = beggars.filter{ $0.stage == storyStage}[0]
        let differenceGoalandNowMoney = nowBeggar.goalMoney - nowBeggar.nowMoney
        
        if differenceGoalandNowMoney > moneyForSave {
            returnMoney = nowBeggar.nowMoney + moneyForSave
            moneyForSave = 0
        } else{
            returnMoney = nowBeggar.goalMoney
            moneyForSave -= differenceGoalandNowMoney
        }
        return returnMoney
    }
    
}
