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
    
    var body: some View {
        ZStack {
            Image("MainResultOverlay")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 343, height: 370)
            
            VStack(spacing: 20) {
                Text("추정 소요금액")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Text("이번 요리에서는 총\n\(historyToShow.menuPrice)원이 소요되었어요.")
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                
                Text("총 \(historyToShow.savedMoney)을 아끼셨군요!\n거지에게 기부해주세요.")
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    showOverlay = false
                    moneyForSave = historyToShow.savedMoney
                }) {
                    Image("OverlayButton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 220, minHeight: 60)
                }
                .padding(.bottom, 20)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
        .edgesIgnoringSafeArea(.all)
    }
}

