//
//  CameraView.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/31/24.
//

import SwiftUI
import AVFoundation

struct CookCameraView: View {
    @ObservedObject var viewModel = CameraViewModel()
    @EnvironmentObject var cookViewModel: CookViewModel
    @Environment(NavigationManager.self) var navigationManager
    
    var body: some View {
        ZStack {
            viewModel.cameraPreview.ignoresSafeArea()
                .onAppear{
                    viewModel.configure()
                }
            
            VStack {
                
                Spacer()
                
                HStack{
                    // 찍은 사진 미리보기
                    Button(action: {
                    }) {
                        if let previewImage = viewModel.recentImage {
                            Image(uiImage: previewImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height:75)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .aspectRatio(1, contentMode: .fit)
                                .onAppear{
                                    cookViewModel.recentImage = viewModel.recentImage
                                }
                        } else{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 3)
                                .frame(width: 75, height: 75)
                                .foregroundStyle(.white)
                                .opacity(0.0)
                        }
                    }.frame(width:75)
                        .padding()
                    
                    Spacer()
                    
                    // 사진찍기 버튼
                    Button(action: {
                        viewModel.capturePhoto()
                        navigationManager.pop()
                    }) {
                        Circle()
                            .stroke(lineWidth: 5)
                            .frame(width: 75, height: 75)
                            .padding()
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                    
                    // 전후면 카메라 교체
                    Button(action: {viewModel.changeCamera()}) {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.white)
                    }
                    .frame(width: 75, height: 75)
                    .padding()
                }
            }
            .foregroundColor(.white)
        }
        .opacity(viewModel.shutterEffect ? 0 : 1)
    }
}


struct CameraPreviewView: UIViewRepresentable {
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    let session: AVCaptureSession
    func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView()
        
        view.backgroundColor = .black
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        view.videoPreviewLayer.cornerRadius = 0
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.connection?.videoOrientation = .portrait
        
        return view
    }
    
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {
        
    }
}
