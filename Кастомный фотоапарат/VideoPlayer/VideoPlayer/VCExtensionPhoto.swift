//
//  VCExtensionPhoto.swift
//  ChefMarket_2.0
//
//  Created by Админ on 05.08.2020.
//  Copyright © 2020 itMegaStar. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    func tapedGaleruPhoto(completion: @escaping(() -> ())){
        
        if MultimediaOpportunities.userSeeAlerts { //уже дал доступ
            completion()
            return
        }
        
        MultimediaOpportunities.checkCamera { (_) in
            MultimediaOpportunities.checkPhotoLibraryPermission {(_) in
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    
    private func openFotoCamera(pickerVC: UIImagePickerController) {
        
        pickerVC.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        pickerVC.allowsEditing = false
        pickerVC.sourceType = .camera
        
        self.navigationController?.present(pickerVC, animated: true, completion: nil)
        
    }
    
    
    private func openAlbum(pickerVC: UIImagePickerController){
        pickerVC.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        pickerVC.allowsEditing = true
        pickerVC.sourceType = .photoLibrary
        pickerVC.modalPresentationStyle = .custom

        self.navigationController?.present(pickerVC, animated: true, completion: nil)
    }
    
    
    private func alertNoMultimedia(camera: Bool){
        
        let title = camera ? "Необходимо разрешить приложению использование фото камеры" : "Необходимо разрешить приложению использование галереи"
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "Ok", style: .default) { (_) in
            if let url = NSURL(string: UIApplication.openSettingsURLString) as URL? {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - OPEN
    
    func openCamera(pickerVC: UIImagePickerController){
        if MultimediaOpportunities.accessAllowedCamera == true {
            //есть доступ к камере
            self.openFotoCamera(pickerVC: pickerVC)
        } else {
            //нет доступа к камере
            self.alertNoMultimedia(camera: true)
        }
    }
    
    func openAlbom(pickerVC: UIImagePickerController){
        if MultimediaOpportunities.accessAllowedPhotos == true {
            //есть доступ к фото
            self.openAlbum(pickerVC: pickerVC)
        } else {
            //нет доступа к альбомам
            self.alertNoMultimedia(camera: false)
        }
    }
    
}
