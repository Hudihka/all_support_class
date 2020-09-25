//
//  UIView.swift
//  trlnk-demo
//
//  Created by Админ on 02.09.2020.
//  Copyright © 2020 AITIMegastar. All rights reserved.
//

import Foundation
import UIKit
import Nuke

extension UIImageView{

    func loadImage(imageURL: URL?,
                   placeholder: UIImage? = UIImage(named: "dowloadImage"), //nil значит вообще не будет
        completion:(() -> Void)?){


        guard let imageURL = imageURL else {
            self.image = placeholder
            completion?()
            return
        }

        self.dowloadNuke(imageURL: imageURL, placeholder: placeholder) {
            completion?()
        }
    }

    func loadImage(imageURLString: String?,
                   placeholder: UIImage? = UIImage(named: "dowloadImage"), //nil значит вообще не будет
        completion:(() -> Void)?){


        guard let str = imageURLString, let imageURL = URL(string: str) else {
            self.image = placeholder
            completion?()
            return
        }

        self.dowloadNuke(imageURL: imageURL, placeholder: placeholder) {
            completion?()
        }
    }


    private func dowloadNuke(imageURL: URL,
                             placeholder: UIImage?,
                             completion:(() -> Void)?){

        var option = ImageLoadingOptions.shared

        if placeholder != nil {
            option.placeholder = placeholder
        }

        Nuke.loadImage(with: imageURL,
                       options: option,
                       into: self,
                       progress: nil) { (result) in
                        completion?()
        }
    }


}


