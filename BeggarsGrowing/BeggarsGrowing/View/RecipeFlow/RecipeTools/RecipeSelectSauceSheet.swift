//
//  RecipeSelectSauceSheet.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 8/2/24.
//


import SwiftUI

struct RecipeSelectSauceSheetView: View {
    @State private var searchText = ""
    @State private var selectedSauces: Set<String> = []
    @Environment(\.presentationMode) var presentationMode
        
    @Binding var selectedSaucesList: [String]
    @Binding var selectedSaucesAmountList: [String]
    
    let sauces = sauceData().sauces
    
    var filteredSauces: [String] {
        if searchText.isEmpty {
            return sauces
        } else {
            return sauces.filter {$0.contains(searchText)}
        }
        
    }
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                Text("재료")
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                Spacer()
                Button(action: {
                    // 완료 버튼 액션
                    DispatchQueue.main.async{
                        for sauce in selectedSauces {
                            selectedSaucesList.append(sauce)
                            selectedSaucesAmountList.append("")
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }){
                    Text("완료")
                        .foregroundColor(.orange)
                        .font(.system(size: 16))
                        .fontWeight(.heavy)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 26)
            .padding(.top, 17)
            SearchBar(text: $searchText)
                .frame(height: 36)
                .padding(.horizontal, 8)
                .padding(.bottom, 9)
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(filteredSauces, id:\.self) { sauce in
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(selectedSauces.contains(sauce) ? Color.yellow.opacity(0.3) : Color(red: 242/255, green: 245/255, blue: 240/255))
                                .frame(height: 50)
                            Button(action:{
                                if selectedSauces.contains(sauce) {
                                    selectedSauces.remove(sauce)
                                } else {
                                    selectedSauces.insert(sauce)
                                }
                            }, label:{
                                HStack(spacing: 0){
                                    Image(systemName: selectedSauces.contains(sauce) ? "checkmark.square.fill" : "square")
                                        .font(.title3)
                                        .foregroundColor(.orange)
                                        .padding(.leading, 15)
//                                    Image(sauce)
//                                        .resizable()
//                                        .frame(width: 30, height: 30)
//                                        .padding(.leading, 20)
                                    Text(sauce)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .padding(.leading, 10)
                                    
                                    Spacer()
                                }
                            })
                            
                        }
                        .padding(.bottom, 8)
                    }
                }
                .padding(.horizontal, 16)
                
            } // scrl
        } //v
    }
}
