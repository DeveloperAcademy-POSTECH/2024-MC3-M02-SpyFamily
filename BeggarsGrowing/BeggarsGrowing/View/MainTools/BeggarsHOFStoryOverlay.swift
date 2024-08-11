//
//  BeggarsHOFStoryOverlay.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 8/10/24.
//

import SwiftUI

import SwiftUI

struct BeggarsHOFStoryOverlay: View {
    
    let beggarsList = BeggarsList().beggars
    
    @AppStorage("StoryStage") var storyStage: Int = 0
    @AppStorage("MoneyFoRSave") var moneyForSave: Int = 0
    
    @State private var beggarToggle : Bool = true
    
    @Binding var showStoryOverlay : Bool
    @Binding var overlayIndex : Int
    @Binding var showOverlayForNewBeggar : Bool
    
    var body: some View {
        ZStack {
            Image("MainResultOverlay")
                .resizable()
                .frame(width: 460, height: 662)
                .scaledToFit()
                .overlay{
                    VStack{
                        if storyStage > overlayIndex{
                            Button(action:{
                                beggarToggle.toggle()
                            }, label:{
                                Image(beggarToggle ? "\(beggarsList[overlayIndex].image)_2" : beggarsList[overlayIndex].image)
                                    .resizable()
                                    .frame(maxWidth: 131,maxHeight: 197)
                                    .aspectRatio(contentMode: .fit)
                            })
                        } else{
                            Image(beggarsList[overlayIndex].image)
                                .resizable()
                                .frame(maxWidth: 131,maxHeight: 197)
                                .scaledToFit()
                        }
                        
                        ScrollView{
                            VStack{
                                Text(beggarsList[overlayIndex].story)
                            }
                        }
                        .frame(width:290, height:180)
                        
                        Button(action:{
                            withAnimation(.spring()) {
                                showStoryOverlay = false
                            }
                        }, label:{
                            Image("StoryDismiss")
                                .resizable()
                                .frame(maxWidth: 230, maxHeight: 70)
                                .padding(.top)
                        })
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            if showOverlayForNewBeggar{
                DispatchQueue.main.async{
                    overlayIndex = storyStage
                    showOverlayForNewBeggar = false
                }
            }
        }
    }
}

