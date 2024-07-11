//
//  CameraView.swift of CameraView-Demo
//
//  Created by Tomasz Kurylik
//    - Twitter: https://twitter.com/tkurylik
//    - Mail: tomasz.kurylik@mijick.com
//    - GitHub: https://github.com/FulcrumOne
//
//  Copyright ©2024 Mijick. Licensed under MIT License.


import SwiftUI
import MijickCameraView

struct CameraView: View {
    @ObservedObject private var manager: CameraManager = .init(
        outputType: .photo,
        cameraPosition: .back,
        cameraFilters: [.init(name: "CISepiaTone")!],
        flashMode: .off,
        isGridVisible: true,
        focusImageColor: .yellow,
        focusImageSize: 92
    )
    @State private var isPopupPresented: Bool = false


    var body: some View {
        createClickMeButton()
            .fullScreenCover(isPresented: $isPopupPresented, content: createCameraController)
    }
}
private extension CameraView {
    func createClickMeButton() -> some View {
        Button(action: { isPopupPresented = true} ) {
            Text("Click me!")
        }
    }
    func createCameraController() -> some View {
        MCameraController(manager: manager)
            //.lockOrientation(AppDelegate.self)
            .onImageCaptured(onImageCaptured)
            .onVideoCaptured(onVideoCaptured)
            .afterMediaCaptured(afterMediaCaptured)
            .onCloseController(onCloseController)
    }
}

// MARK: - Camera Actions
private extension CameraView {
    func onImageCaptured(_ imageData: UIImage) {
        print("IMAGE CAPTURED")
    }
    func onVideoCaptured(_ videURL: URL) {
        print("VIDEO CAPTURED")
    }
    func afterMediaCaptured() {
        isPopupPresented = false
    }
    func onCloseController() {
        isPopupPresented = false
    }
}
