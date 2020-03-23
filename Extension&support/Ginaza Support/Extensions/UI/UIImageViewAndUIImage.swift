//
//  UIImageViewAndUIImage.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

// MARK: - UIImage

extension UIImage {
    func noir() -> UIImage { //делаем изображение черно белым
        let context = CIContext(options: nil)

        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")
        currentFilter!.setValue(CIImage(image: self), forKey: kCIInputImageKey)

        guard let output = currentFilter!.outputImage else {
            return self
        }

        let cgimg = context.createCGImage(output, from: output.extent)
        let processedImage = UIImage(cgImage: cgimg!, scale: scale, orientation: imageOrientation)
        return processedImage
    }

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

    func getKeyFromData() -> String { //получаем уникальный ключ из изображения
        let data = self.pngData()
        if let str = data?.base64EncodedString() {
            let clearStr = str.deleteSumbol(sumbol: "/").deleteSumbol(sumbol: ".")
            return String(clearStr.characters.suffix(200))
        }
        return "key"
    }

    //2 метода ниже нужны для сжатия изображения до 4х МБ
    func compactImage() -> UIImage {
        let koef = self.getKoefCompress()
        if koef != 1, let data = self.jpegData(compressionQuality: koef), let image = UIImage(data: data) {
            return image
        }

        return self
    }

    private func getKoefCompress() -> CGFloat {
        let maxData = 10_216_790
        if let factData = self.pngData(), factData.count > maxData {
            return CGFloat(maxData / factData.count)
        }

        return 1
    }
}

// MARK: - UIImageView

extension UIImageView {
    func blackAndWhiteImage() {
        if let img = self.image {
            self.image = img.noir()
        }
    }
}
