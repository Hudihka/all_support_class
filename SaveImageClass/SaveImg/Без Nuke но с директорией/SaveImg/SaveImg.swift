//
//  SaveImageClass.swift
//  NUKEandDirectory
//
//  Created by Username on 06.06.2019.
//  Copyright © 2019 Username. All rights reserved.
//

import UIKit

fileprivate let imagePlaceholder: UIImage? = UIImage(named: "dowloadImage")

class SaveImg: NSObject {
    
    static let shared = SaveImg()
    private let managerDirectory = SaveImпDirectory.shared
    
    //сохранение/получение изображения
    
    func updateUI(imageURL: URL?,
                  imageView: UIImageView,
                  placeholder: UIImage? = imagePlaceholder, //nil значит вообще не будет
        completion:((Error?) -> Void)?) {
        
        imageView.image = placeholder
        
        guard let imageURL = imageURL else {
            completion?(customError)
            return
        }
        
        let keySave = imageURL.keyURL
        
        if let image = managerDirectory.loadImageFromDiskWith(name: keySave) {
            imageView.image = image
            completion?(nil)
        } else {
            self.standartDowload(imageURL: imageURL,
                                 keySave: keySave,
                                 imageView: imageView) { (error) in
                                    completion?(error)
            }
        }
    }
    
    func updateUI(imageURL: String?,
                  imageView: UIImageView,
                  placeholder: UIImage? = imagePlaceholder,  //nil значит вообще не будет,
        completion:((Error?) -> Void)?) {
        
        if let imageURL = imageURL {
            self.updateUI(imageURL: URL(string: imageURL),
                                    imageView: imageView,
                                    placeholder: placeholder) { (error) in
                                        completion?(error)
            }
        } else {
            if let placeholder = placeholder {
                imageView.image = placeholder
            }
            completion?(customError)
        }
        
    }
    
    
    private var customError: Error{
        let error = NSError(domain: "не корректный URL", code: 0, userInfo: nil)
        return error
    }
    
    
    //MARK: - Dowload
    
    
    private func standartDowload(imageURL: URL,
                                 keySave: String,
                                 imageView: UIImageView,
                                 completion:((Error?) -> Void)?){
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let contentUrlData = try? Data(contentsOf: imageURL), let imageSave = UIImage(data: contentUrlData) {
                
                self.managerDirectory.saveImage(image: imageSave, key: keySave)
                
                DispatchQueue.main.async {
                    imageView.image = imageSave
                    completion?(nil)
                }
            } else {
                DispatchQueue.main.async {
                    completion?(self.customError)
                }
            }
            
            
        }
    }
    
    
}
