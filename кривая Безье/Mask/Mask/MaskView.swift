//
//  MaskView.swift
//  Mask
//
//  Created by Username on 26.01.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import UIKit


class MaskView: UIView {

    private let rootLayer = CALayer()
    private let maskLayer = CALayer()


    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }


    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        commonInit()
    }




    private func commonInit() {


        if let maskingImage = UIImage(named: "PolygonPDF"){
            let maskingLayer = CALayer()

            maskingLayer.frame = self.bounds
            maskingLayer.contents = maskingImage.cgImage

            self.layer.contents = UIImage(named: "oboi-priroda")?.cgImage
            self.layer.mask = maskingLayer

        }

        self.layer.masksToBounds = false


    }


    private func addShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
    }

}
