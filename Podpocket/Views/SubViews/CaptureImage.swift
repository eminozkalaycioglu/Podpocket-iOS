//
//  CaptureImage.swift
//  Podpocket
//
//  Created by Emin on 1.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import SwiftUI


struct CaptureImageView {
    
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: self.$isShown, image: self.$image)
    }
}
extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
        
    }
}



class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var isCoordinatorShown: Bool
    @Binding var imageInCoordinator: UIImage?
    init(isShown: Binding<Bool>, image: Binding<UIImage?>) {
        _isCoordinatorShown = isShown
        _imageInCoordinator = image
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        imageInCoordinator = unwrapImage
        withAnimation {
            isCoordinatorShown = false

        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        withAnimation {
            isCoordinatorShown = false

        }
    }
    
    
    

}
