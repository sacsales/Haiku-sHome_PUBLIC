//
//  ImagePicker.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 14/10/2023.
//

import Foundation
import UIKit
import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
    
    
    @Binding var selectedImage: UIImage?
    @Binding var isPickerShowing: Bool
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        
        return imagePicker
        
    }
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}


class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parent : ImagePicker
    
    init(_ picker: ImagePicker) {
        self.parent = picker
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //run code when user has selected image
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //yay image got
            DispatchQueue.main.async {
                self.parent.selectedImage = image
            }
        }
        
        parent.isPickerShowing = false
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //run code when user has cancelled ui
        parent.isPickerShowing = false
    }
    
    
}

