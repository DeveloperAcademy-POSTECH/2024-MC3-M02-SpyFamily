//
//  RecipeImagePicker.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 8/4/24.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
                parent.saveImage(imageName: "userImage", image: image)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

extension ImagePicker {
    // 이미지를 파일 시스템에 저장하는 메서드
    func saveImage(imageName: String, image: UIImage) {
        if let data = image.pngData() {
            let filename = getDocumentsDirectory().appendingPathComponent("\(imageName).png")
            try? data.write(to: filename)
        }
    }
    
    // 도큐먼트 디렉토리의 URL을 반환하는 메서드
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
