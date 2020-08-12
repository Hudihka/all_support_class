//
//  VCExtensionPhoto.swift
//  ChefMarket_2.0
//
//  Created by Админ on 05.08.2020.
//  Copyright © 2020 itMegaStar. All rights reserved.
//

import Foundation


extension UIViewController {
    
    //показ алерта
    func tapedReloadPhoto(completion: @escaping(() -> ())){
        
        MultimediaOpportunities.checkCamera { (_) in
            MultimediaOpportunities.checkPhotoLibraryPermission {(_) in
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
        
    }
    
    //MARK: ALERT
    
    func psesentAlertPhoto(profile: Profile?,
                           flagDeletePhoto: Bool = false,
                           pickerVC: UIImagePickerController,
                           openImageZoom: @escaping((UIImage) -> ()),
                           deletePhoto: @escaping(() -> ())){
        
        
        let alertController = UIAlertController(title: "\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        
        //хедер с фотографиями
        
        let rect = CGRect(x: 0, y: 10, width: alertController.view.bounds.size.width - 17, height: 102)
        let customView = ViewHeaderAlert(frame: rect)
        
        customView.blockOpenCamera = {
            alertController.dismiss(animated: true) {
                if MultimediaOpportunities.accessAllowedCamera == true {
                    //есть доступ к камере
                    self.openFotoCamera(pickerVC: pickerVC)
                } else {
                    //нет доступа к камере
                    self.alertNoAcces(true)
                }
            }
        }
        
        customView.blockOpenPhoto = { image in
            alertController.dismiss(animated: true) {
                openImageZoom(image)
            }
        }
        
        customView.backgroundColor = .clear
        alertController.view.addSubview(customView)
        
        //ВЫбрать фото
        let somethingAction = UIAlertAction(title: "Выбрать Фото", style: .default, handler: { _ in
            //экран с альбомами
            
            if MultimediaOpportunities.accessAllowedPhotos == true {
                //есть доступ к фото
                self.openAlbum(pickerVC: pickerVC)
            } else {
                //нет доступа к альбомам
                self.alertNoAcces(false)
            }
            
        })
        
        somethingAction.setValue(UIColor(rgb: 0x333333), forKey: "titleTextColor")
        
        //удалить фото
        var deleteAction: UIAlertAction? = nil
        
        if profile?.linkPhoto != nil, flagDeletePhoto == false {
            deleteAction = UIAlertAction(title: "Удалить Фото", style: .default, handler: { _ in
                deletePhoto()
            })
            
            deleteAction?.setValue(UIColor(rgb: 0xFF3B30), forKey: "titleTextColor")
        }
        
        //отмена
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        cancelAction.setValue(UIColor(rgb: 0x808080), forKey: "titleTextColor")
        
        
        //добавляем фото
        alertController.addAction(somethingAction)
        if deleteAction != nil {
            alertController.addAction(deleteAction!)
        }
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion:{})
        
        
    }
    
    func deletePhoto(yesAction: @escaping(() -> Void)){
        
        self.presentAddCardAlert(title: "Удалить фото",
                                 text: "Вы уверены, что хотите удалить эту фотографию?",
                                 textYesAction: "Удалить") {(_) in
                                    yesAction()
        }
    }
    
    private func openFotoCamera(pickerVC: UIImagePickerController) {
        
        pickerVC.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        pickerVC.allowsEditing = false
        pickerVC.sourceType = .camera
        
        self.navigationController?.present(pickerVC, animated: true, completion: nil)
        
    }
    
    private func openFotoGalery(pickerVC: UIImagePickerController) {
        
        pickerVC.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        pickerVC.allowsEditing = true
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
    
    
    private func alertNoAcces(_ camera: Bool){
        
        let text = camera ? "Необходимо разрешить приложению использование камеры" : "Необходимо разрешить приложению использование галереи"
        
        presentSympleAlert(text: text, yesAction: {
            action in
            if let url = NSURL(string: UIApplicationOpenSettingsURLString) as URL? {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
    }
    
    
    
}
