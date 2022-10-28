//
//  SaveImageClass.swift
//  NUKEandDirectory
//
//  Created by Username on 06.06.2019.
//  Copyright © 2019 Username. All rights reserved.
//

import UIKit
import Nuke

class SaveImageClass: NSObject {
    
    private static let imagePlaceholder: UIImage? = UIImage(named: "testPlaceholder")

    //сохранение/получение изображения

    static func updateUI(imageURL: URL?,
                         imageView: UIImageView,
                         placeholder: UIImage? = SaveImageClass.imagePlaceholder, //nil значит вообще не будет
                         completion:((Error?) -> Void)?) {
        
        imageView.image = placeholder
        
        guard let imageURL = imageURL else {
            completion?(SaveImageClass.customError)
            return
        }
        
        let keySave = imageURL.keyURL
        let managerDirectory = SaveImageDirectory.shared
        

        if let image = managerDirectory.loadImageFromDiskWith(name: keySave) {
            imageView.image = image
            completion?(nil)
        } else {
            
            var option = ImageLoadingOptions.shared

            if placeholder != nil {
                option.placeholder = placeholder
            }
            
            Nuke.loadImage(with: imageURL,
                           options: option,
                           into: imageView,
                           progress: nil) { (loadingImage, error) in
                            if let error = error {
                                completion?(error)
                                print(error)
                            }else if let image = loadingImage?.image {
                                DispatchQueue.global(qos: .userInitiated).async {
                                    managerDirectory.saveImage(image: image, key: keySave)
                                }
                                completion?(nil)
                            }
            }
        }
    }
    
    static func updateUI(imageURL: String?,
                         imageView: UIImageView,
                         placeholder: UIImage? = SaveImageClass.imagePlaceholder, //nil значит вообще не будет,
                         completion:((Error?) -> Void)?) {
        
        if let imageURL = imageURL {
            SaveImageClass.updateUI(imageURL: URL(string: imageURL),
                                    imageView: imageView,
                                    placeholder: placeholder) { (error) in
                                        completion?(error)
            }
        } else {
            if let placeholder = placeholder {
                imageView.image = placeholder
            }
            completion?(SaveImageClass.customError)
        }
        
    }

    
    static private var customError: Error{
        let error = NSError(domain: "не корректный URL", code: 0, userInfo: nil)
        return error
    }


}
