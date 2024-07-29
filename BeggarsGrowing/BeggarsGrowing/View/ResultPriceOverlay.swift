//
//  ResultPriceOverlay.swift
//  BeggarsGrowing
//
//  Created by 이예형 on 7/27/24.
//

import SwiftUI

struct SampleView: View {
    @State private var showOverlay = false

    var body: some View {
        ZStack {
            // Your main content
            VStack {
                Text("테스트")
                    .font(.largeTitle)
                    .padding()

                Button(action: {
                    showOverlay.toggle()
                }) {
                    Text("거지 다키웠수다!")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }

            // 조건 달성 시 오버레이 띄우기
            if showOverlay {
                ResultPriceOverlay()
                    .transition(.opacity)
                    .onTapGesture {
                        showOverlay = false
                    }
            }
        }
        .animation(.easeInOut, value: showOverlay)
    }
}

struct ResultPriceOverlay: View {
    var body: some View {
        ZStack {
            Image("OverlayBG")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 343, height: 460)

            VStack(spacing: 20) {
                Text("추정 소요금액")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                Text("이번 요리에서는 총\n2700원이 소요되었어요.")
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)

                Text("총 13000원을 아끼셨군요!\n거지에게 기부해주세요.")
                    .multilineTextAlignment(.center)

                Button(action: {
                    // 기부하기 액션
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

#Preview {
    SampleView()
}
