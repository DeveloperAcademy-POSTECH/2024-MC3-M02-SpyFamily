//
//  CameraModel.swift
//  BeggarsGrowing
//
//  Created by 변준섭 on 7/31/24.
//

import SwiftUI
import AVFoundation
import Combine

class CameraViewModel: ObservableObject {
    private let model: Camera
    private let session: AVCaptureSession
    private var isCameraBusy = false
    let hapticImpact = UIImpactFeedbackGenerator()
    
    let cameraPreview: AnyView
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var recentImage: UIImage?
    @Published var isFlashOn = false
    @Published var isSilentModeOn = false
    @Published var shutterEffect = false
    
    func configure() {
        model.requestAndCheckPermissions()
    }
    
    func switchFlash() {
        isFlashOn.toggle()
        model.flashMode = isFlashOn == true ? .on : .off
    }
    
    func switchSilent() {
        isSilentModeOn.toggle()
        model.isSilentModeOn = isSilentModeOn
    }
    
    func capturePhoto() {
        if isCameraBusy == false {
            hapticImpact.impactOccurred()
            withAnimation(.easeInOut(duration: 0.1)) {
                shutterEffect = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    self.shutterEffect = false
                }
            }
            model.capturePhoto()
            print("[CameraViewModel]: Photo captured!")
        } else {
            print("[CameraViewModel]: Camera's busy.")
        }
    }
    
    func changeCamera() {
        model.switchCamera()
        print("[CameraViewModel]: Camera changed!")
    }
    
    init() {
        model = Camera()
        session = model.session
        cameraPreview = AnyView(CameraPreviewView(session: session))
        
        model.$recentImage.sink { [weak self] (photo) in
            guard let pic = photo else { return }
            self?.recentImage = pic
        }
        .store(in: &self.subscriptions)
        
        model.$isCameraBusy.sink { [weak self] (result) in
            self?.isCameraBusy = result
        }
        .store(in: &self.subscriptions)
    }
}



class Camera: NSObject, ObservableObject{
    @EnvironmentObject var cookViewModel: CookViewModel
    
    var session = AVCaptureSession()
    var videoDeviceInput: AVCaptureDeviceInput!
    let output = AVCapturePhotoOutput()
    var photoData = Data(count: 0)
    var isSilentModeOn = false
    var flashMode: AVCaptureDevice.FlashMode = .off
    
    @Published var recentImage: UIImage?
    @Published var isCameraBusy = false
    
    private var currentPosition: AVCaptureDevice.Position = .back
    
    // 카메라 셋업 과정을 담당하는 함수, positio
    func setUpCamera() {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                for: .video, position: .back) {
            do { // 카메라가 사용 가능하면 세션에 input과 output을 연결
                videoDeviceInput = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(videoDeviceInput) {
                    session.addInput(videoDeviceInput)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                    output.isHighResolutionCaptureEnabled = true
                    output.maxPhotoQualityPrioritization = .quality
                }
                session.startRunning() // 세션 시작
            } catch {
                print(error) // 에러 프린트
            }
        }
    }
    
    func switchCamera() {
        session.beginConfiguration()
        session.removeInput(videoDeviceInput)
        
        currentPosition = currentPosition == .back ? .front : .back
        
        if let newDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: currentPosition) {
            do {
                let newInput = try AVCaptureDeviceInput(device: newDevice)
                if session.canAddInput(newInput) {
                    session.addInput(newInput)
                    videoDeviceInput = newInput
                }
            } catch {
                print(error)
            }
        }
        
        session.commitConfiguration()
    }
    
    func capturePhoto() {
        // 사진 옵션 세팅
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = self.flashMode
        
        self.output.capturePhoto(with: photoSettings, delegate: self)
        print("[Camera]: Photo's taken")
    }
    
    func savePhoto(_ imageData: Data) {
        guard let image = UIImage(data: imageData) else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        // 사진 저장하기
        print("[Camera]: Photo's saved")
    }
    
    func requestAndCheckPermissions() {
        // 카메라 권한 상태 확인
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            // 권한 요청
            AVCaptureDevice.requestAccess(for: .video) { [weak self] authStatus in
                if authStatus {
                    DispatchQueue.main.async {
                        self?.setUpCamera()
                    }
                }
            }
        case .restricted:
            break
        case .authorized:
            // 이미 권한 받은 경우 셋업
            setUpCamera()
        default:
            // 거절했을 경우
            print("Permession declined")
        }
    }
}

extension Camera: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        self.isCameraBusy = true
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        if isSilentModeOn {
            print("[Camera]: Silent sound activated")
            AudioServicesDisposeSystemSoundID(1108)
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        if isSilentModeOn {
            AudioServicesDisposeSystemSoundID(1108)
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        self.photoData = imageData
        self.recentImage = UIImage(data: imageData)
        //        self.savePhoto(imageData)
        
        print("[CameraModel]: Capture routine's done")
        self.isCameraBusy = false
    }
}
