//
//  FilterWorker.swift
//  TestFilterProject
//
//  Created by Anastasia Sokolan on 27.09.2020.
//  Copyright © 2020 Anastasia Sokolan. All rights reserved.
//

import UIKit
//с помощью этого класса мы инвертируем UIImage в CIImage и наоборот но уже с примененным фильтром

class FilterWorker {
    private let image: UIImage
	
    private var filter = CIFilter(name: "CIExposureAdjust")! //сам фильтр экспозиция
	//графический контекст
    private var context = CIContext()
    
    init(image: UIImage) {
        self.image = image
        
        filter.setValue(CIImage(image: image)!, forKey: kCIInputImageKey)//ключ для изображени
																		 //что я импортнул изображение
    }
    
    func apply(with intensity: Float) -> CIImage {
        filter.setValue(intensity, forKey: kCIInputEVKey) //применяем в фильтр изображение по данному ключу и с данной интенсивностью
        let outputImage = filter.outputImage! //получае выходное изображение
        return outputImage.oriented(image.cgImageOrientation) //получение изображения с учетом ориентации
    }
    
    func applyUIImage(with intensity: Float) -> UIImage {
        let filteredImage = apply(with: intensity)
        let cgImage = context.createCGImage(filteredImage, from: filteredImage.extent) //получаем CI изображение уже подредактированное
        
        return UIImage(cgImage: cgImage!)
    }
}
