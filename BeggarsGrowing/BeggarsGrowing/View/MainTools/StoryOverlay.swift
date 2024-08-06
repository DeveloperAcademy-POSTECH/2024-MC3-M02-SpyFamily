//
//  StoryOverlay.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 8/6/24.
//

import SwiftUI

struct StoryOverlay: View {
    
    @AppStorage("StoryStage") var storyStage: Int = 0
    let beggarsList = BeggarsList().beggars
    
    @Binding var showStoryOverlay : Bool
    @Binding var isAnimating: Bool
    var animationNamespace: Namespace.ID
    
    var body: some View {
        ZStack {
            Image("MainResultOverlay")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 460, height: 662)
            
            VStack{
                Text(beggarsList[storyStage].story)
                Button(action:{
                    withAnimation(.spring()) {
                        showStoryOverlay = false
                    }
                }, label:{
                    Text("닫기")
                    //여기에 닫기 버튼 들어가야 함. 현재 닫기 텍스트로 대체
                })
            }
            .frame(width:270)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            withAnimation(.spring()) {
                isAnimating.toggle()
            }
        }
    }
}

