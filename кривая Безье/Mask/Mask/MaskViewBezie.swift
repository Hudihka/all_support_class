//
//  MaskViewBezie.swift
//  Mask
//
//  Created by Username on 26.01.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable class MaskViewBezie: UIView {


    private var path: UIBezierPath{

        let bPath = UIBezierPath()

        bPath.move(to: CGPoint(x: 10, y: 10)) //начало пути
        bPath.addLine(to: CGPoint(x: 30, y: 20))
        bPath.addLine(to: CGPoint(x: 120, y: 30))
        bPath.addLine(to: CGPoint(x: 240, y: 120))
        bPath.addLine(to: CGPoint(x: 240, y: 130))
        bPath.addLine(to: CGPoint(x: 200, y: 110))
        bPath.addLine(to: CGPoint(x: 50, y: 200))

        bPath.close()

        bPath.lineWidth = 5
        #colorLiteral(red: 1, green: 0.1805555556, blue: 0.6902940538, alpha: 1).setStroke()

        return bPath
    }

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

    override func draw(_ rect: CGRect) {

//        //здесь мы просто тестили нашу кривую
//
//        path.stroke()
//
//        //код ниже закрашивает огороженную область в нужный цвет
//
//        path.addClip()
//        UIColor.green.setFill()
//        let rectPath = UIBezierPath(rect: rect)
//        rectPath.fill()

    }




    private func commonInit() {

        path.addClip()

        let mask           = CAShapeLayer()
        mask.path          = path.cgPath

        layer.contents = #imageLiteral(resourceName: "oboi-priroda").cgImage
        layer.mask         = mask
    }


    private func addShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
    }

}
