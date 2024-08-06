//
//  BeggarsModel.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/23/24.
//

import SwiftUI
import SwiftData

@Model class Beggars {
    
    /// 거지 고유값
    @Attribute(.unique) var id: UUID = UUID()
    /// 순서
    var stage: Int
    /// 거지명
    var name: String
    /// 이미지
    var image: String
    /// 목표액
    var goalMoney: Int
    /// 현재 합계액
    var nowMoney: Int
    /// 클리어 날짜
    var clearDate: Date?
    
    init(stage: Int, name: String, image: String, goalMoney:Int, nowMoney:Int) {
        self.stage = stage
        self.name = name
        self.image = image
        self.goalMoney = goalMoney
        self.nowMoney = nowMoney
    }
}

struct BeggarsForm {
    let name: String
    let image: String
    let goalMoney: Int
    let story: String
    let ment: [String]
}

struct BeggarsList {
    // 업데이트 가능한 struct
    let beggars: [BeggarsForm] = [
        BeggarsForm(name: "정글 거지",
                    image: "JungleBeggar",
                    goalMoney: 5000,
                    story: "저는 돈이 없어서 정글에서 동물들과 살았어요. 씻지도 잘 먹지도 못했던 이 거지생활을 그만두고, 정말 인간다운 삶을 살고 싶어졌죠!!! 의지를 가지고 알바자리를 찾아보려는데, 제 더러운 차림에 계속 문전박대만 당하고 있어요. 이발도 하고, 몸도 깨끗하게 씻고 싶어요. 당신이 요리를 함으로써 아끼신 돈으로 저를 도와주실 수 있어요. 6,000원이 필요해요 제발요!",
                    ment: ["정글생활동안 제일 친한 친구는 아기늑대였어요.", "이래보여도 저 꽤 어리답니다. 지금은 아저씨같아도..!", "도움을 받고 난 후의 제 모습을 기대해주세요. 꽤 귀여울지도? 헤헷", "한 끼 평균 외식비는 약 13,000원이래요. 냉장고 속 재료로 알뜰하게 맛있는 음식을 해볼까요?"]
                   ),
        BeggarsForm(name: "택시 거지",
                    image: "TaxiBeggar",
                    goalMoney: 30000,
                    story: "매일 아침마다 눈뜨는게 너무 힘겨웠어요. 5분만~ 5분만~ 하다보니 항상 늦어지더라구요. 힝.. 그러다 자꾸 택시를 잡게되었고.. 거지가 됐어요. 지금은 길바닥에 나앉아있죠. 이 위기를 넘기면 정말 정신차리고 일찍 일찍 준비할거예요. 당신이 요리를 함으로써 아끼신 돈으로 저를 도와주실 수 있어요. 50,000원이 필요해요. 제발요~~!",
                    ment: ["택시요금은 대체 언제까지 오를까요?", "얼마전, 편의점에서 열일하는 귀여운 정글 거지를 봤어요.", "한 끼 평균 외식비는 약 13,000원이래요. 냉장고 속 재료로 알뜰하게 맛있는 음식을 해볼까요?"]
                   ),
        BeggarsForm(name: "댄서 거지",
                    image: "DancerBeggar",
                    goalMoney: 50000,
                    story: "Dance is my life.. Life is Dancing. 제 신조랍니다. 춤을 추는 순간 세상이 다 제 것 같아, 매일 연습했죠. 그런데, 제 열정이 너무 과했던 걸까요.. 무릎부상이.. 이렇게 거지가 될 만큼 돈을 지불하고도 아직 치료비가 부족해요. 당신이 요리를 함으로써 아끼신 돈으로 저를 도와주실 수 있어요. 50,000원이 필요해요. 다시 춤춰보고싶어요.",
                    ment: ["저는 슬플 때 힙합 댄스를 춰요. 쉘 위 댄스?", "덕분에 택시 거지는 요즘 약속시간보다 1시간 먼저 도착하는 연습을 한대요!", "지금 내 냉장고 속 재료로 맛있는 요리를 해볼까요? 벌써 배고파! 츄릅!"]
                   ),
        BeggarsForm(name: "동상걸린 거지",
                    image: "ColdBeggar",
                    goalMoney: 60000,
                    story: "전 겨울이 제일 싫어요. 가난이 가장 잘 드러나는 시기거든요. 구멍이 숭숭 뚫린 옷을 입고 다니던 어느 날.. 손끝이 너무 아프고 감각이 사라지더라구요. 아뿔싸. 동상에 걸린거예요. 지금도 너무 추워요.. 따뜻한 목폴라와 긴바지를 입을 수 있다면.. 하는 꿈을 꿔요. 당신이 요리를 함으로써 아끼신 돈으로 저를 도와주실 수 있어요. 6만원으로 제게 온기를 선물해주실 수 있나요?",
                    ment: ["덕분에 댄서거지가 다시 춤을 추기 시작했어요! 홍대 어딘가에서 찾을 수 있대요.", "우리나라 동상 환자는 한 해에 약 1만명이래요. 꽤 많죠? 1월을 가장 조심해야해요."]
                   )
    ]
}
