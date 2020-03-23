//
//  UIImageViewAndUIImage.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation
import UIKit




// MARK: - UIImage

extension UIImage {

    //делаем качество изображения подстать нашему девайсу
    func resizeImage(toFill targetView: UIImageView, width: CGFloat, height: CGFloat) -> UIImage {
        let size = self.size

        let widthRatio = width / size.width
        let heightRatio = height / size.height

        var newSize: CGSize
        if widthRatio < heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }


    //меняем альфу изображения

    func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }


}

