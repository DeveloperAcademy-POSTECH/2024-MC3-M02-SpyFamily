//
//  RecipeAddView_Picture.swift
//  BeggarsGrowing
//
//  Created by 이예형 on 7/31/24.
//


import SwiftUI
import PhotosUI

struct RecipeAddView_Picture: View {
    @Environment(NavigationManager.self) var navigationManager
    @EnvironmentObject var viewModel: RecipeViewModel
    
    @State private var showingImagePicker = false
    @State private var image: UIImage?
    
    var body: some View {
        ZStack {
            Color(red: 255/255, green: 250/255, blue: 233/255)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Divider()
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .padding(.bottom, 20)
                // // // // //
                HStack(spacing: 0) {
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(red: 242/255, green: 245/255, blue: 240/255))
                        .overlay(Text("1")
                            .foregroundColor(.black))
                        .padding(.trailing, 10)
                        .padding(.leading, 16)
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(red: 246/255, green: 153/255, blue: 39/255))
                        .overlay(Text("2")
                            .foregroundColor(.white))
                        .padding(.trailing, 10)
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(red: 242/255, green: 245/255, blue: 240/255))
                        .overlay(Text("3")
                            .foregroundColor(.black))
                        .padding(.trailing, 10)
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(red: 242/255, green: 245/255, blue: 240/255))
                        .overlay(Text("4")
                            .foregroundColor(.black))
                        .padding(.trailing, 10)
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(red: 242/255, green: 245/255, blue: 240/255))
                        .overlay(Text("5")
                            .foregroundColor(.black))
                        .padding(.trailing, 10)
                    Spacer()
                }
                .padding(.bottom, 44)
                // // // // //
                VStack(spacing: 12) {
                    HStack(spacing: 0) {
                        Text("요리사진")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("을")
                        Spacer()
                    }
                    HStack {
                        Text("등록해주세요.")
                        Spacer()
                    }
                    .padding(.bottom, 32)
                }
                .font(.title)
                .padding(.leading)
                
                VStack(spacing: 0) {
                    if viewModel.inputImage == nil {
                        Button(action:{
                            showingImagePicker = true
                        }, label:{
                            Rectangle()
                                .frame(width: 320, height: 190)
                                .foregroundColor(Color(red : 242 / 255, green : 245 / 255, blue : 240 / 255))
                                .overlay(
                                    VStack{
                                        Image(systemName: "plus")
                                            .font(.title)
                                            .padding(.bottom, 2)
                                        Text("사진 등록")
                                            .font(.footnote)
                                    }
                                        .foregroundColor(.gray)
                                )
                        })
                    } else {
                        Image(uiImage: viewModel.inputImage!)
                            .resizable()
                            .frame(width: 320, height: 190)
                            .overlay{                          }
                        
                        
                        Button(action:{
                            navigationManager.push(to: .recipeAddLink)
                        }, label:{
                            Text("등록 완료")
                        })
                    }
                    Spacer()
                }
            }
            .navigationTitle("레시피 등록")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$image)
        }
        .onChange(of: image) { newImage in
            viewModel.inputImage = newImage
        }
    }
}
