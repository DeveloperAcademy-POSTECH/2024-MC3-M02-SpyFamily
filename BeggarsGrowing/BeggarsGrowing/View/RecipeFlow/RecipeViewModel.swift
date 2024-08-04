//
//  RecipeViewModel.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 8/2/24.
//


import SwiftUI
import SwiftData

class RecipeViewModel : ObservableObject {
    
    @Published var selectedRecipeforDetail: Recipe = Recipe(menu: "", foods: [""], foodsAmount: [""])
    
    @Published var inputName: String = ""
    @Published var inputImage: UIImage?
    @Published var inputLink: String = ""
    @Published var inputFoods: [String] = []
    @Published var inputFoodsAmount: [String] = []
    @Published var inputSauces: [String] = []
    @Published var inputSaucesAmount: [String] = []
    @Published var inputMemo: String = ""
    
    func finishRecipeRecord() -> Recipe{
        let menu = inputName
        let link = inputLink
        let foods = inputFoods
        let foodsAmount = inputFoodsAmount
        let recipeId = UUID()
        let imageName = saveImageToDocumentsDirectory(image: inputImage, id: recipeId) // 이미지 저장 함수 호출
        let sauces = inputSauces
        let saucesAmount = inputSaucesAmount
        let memo = inputMemo
        
        let recipeToAdd = Recipe(menu: inputName, link: inputLink, foods: inputFoods, foodsAmount: inputFoodsAmount, image:imageName, sauces:inputSauces, saucesAmount: inputSaucesAmount, memo: inputMemo)
        print("Recipe Add Success")
        return recipeToAdd
    }
    
    func reset() {
        self.selectedRecipeforDetail = Recipe(menu: "", foods: [""], foodsAmount: [""])
        self.inputName = ""
        self.inputImage = nil
        self.inputLink = ""
        self.inputFoods = []
        self.inputFoodsAmount = []
        self.inputSauces = []
        self.inputSaucesAmount = []
        self.inputMemo = ""
    }
    
    func loadImage(imageName: String) -> UIImage? {
        let fileManager = FileManager.default
        let imagePath = getDocumentsDirectory().appendingPathComponent("\(imageName).png").path
        if fileManager.fileExists(atPath: imagePath) {
            return UIImage(contentsOfFile: imagePath)
        }
        return nil
    }
    
    // 도큐먼트 디렉토리의 URL을 반환하는 함수
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveImageToDocumentsDirectory(image: UIImage?, id: UUID) -> String {
        guard let image = image, let data = image.pngData() else {
            return ""
        }
        let imageName = id.uuidString // UUID 문자열로 이미지 이름 생성
        let filename = getDocumentsDirectory().appendingPathComponent("\(imageName).png")
        try? data.write(to: filename)
        return imageName
    }
}
