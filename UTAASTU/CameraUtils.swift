//
//  CameraUtils.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 01/08/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import Foundation
import MobileCoreServices
import UIKit

class Camera {
    
    var delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate
    
    init(delegate_: UIImagePickerControllerDelegate & UINavigationControllerDelegate){
        delegate = delegate_
    }
    
    func presentPhotoLibrary(target: UIViewController, canEdit: Bool) {
        
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) && !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
            return
        }
        
        let type = kUTTypeImage as String
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            imagePicker.sourceType = .photoLibrary
            
            if let avaliableTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary){
                
                if (avaliableTypes as NSArray).contains(type) {
                    
                    imagePicker.mediaTypes = [type]
                }
                
            }
            
        } else if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.sourceType = .savedPhotosAlbum
            
            if let avaliableTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum){
                
                if (avaliableTypes as NSArray).contains(type) {
                    
                    imagePicker.mediaTypes = [type]
                }
                
            }
            
        } else {
            return
        }
        
        imagePicker.allowsEditing = canEdit
        imagePicker.delegate = delegate
        target.present(imagePicker, animated: true, completion: nil)
        
        return
        
    }
    
    func presentCamera(target: UIViewController, canEdit: Bool) {
        
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            return
        }
        
        let type = kUTTypeImage as String
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            imagePicker.sourceType = .camera
            
            if let avaliableTypes = UIImagePickerController.availableMediaTypes(for: .camera){
                
                if (avaliableTypes as NSArray).contains(type) {
                    
                    imagePicker.mediaTypes = [type]
                }
                
            }
            
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                imagePicker.cameraDevice = .rear
            }else if UIImagePickerController.isCameraDeviceAvailable(.front){
                imagePicker.cameraDevice = .front
            }
            
        } else {
            return
        }
        
        imagePicker.allowsEditing = canEdit
        imagePicker.delegate = delegate
        target.present(imagePicker, animated: true, completion: nil)
        
        return
        
    }
    
}
