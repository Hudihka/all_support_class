//
//  UIView.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @objc func loadViewFromNib(_ name: String) -> UIView { //добавление вью созданной в ксиб файле
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            return view
        } else {
            return UIView()
        }
    }


    func addShadow() {
        self.layer.masksToBounds = false
//        self.layer.shadowColor = SupportClass.Colors.shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4.0
    }


    func roundedView(rect: UIRectCorner) { //закругление 2х углов вьюшки
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: rect, //[.topLeft, .bottomLeft]
            cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }

    func addRadius(number: CGFloat) {
        self.layer.cornerRadius = number
        self.layer.masksToBounds = true
    }

    func cirkleView() {
        let radius = self.frame.height / 2
        self.addRadius(number: radius)
    }

    func addGradient() { //градиент фона изображения
        let gradient = CAGradientLayer()

        gradient.frame = self.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.8).cgColor]

        self.layer.insertSublayer(gradient, at: 0)
    }

    func recurrenceAllSubviews() -> [UIView] {//получение всех UIView
        var all = [UIView]()
        func getSubview(view: UIView) {
            all.append(view)
            guard !view.subviews.isEmpty else {
                return
            }
            view.subviews.forEach { getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }

    func opasityAllViews(_ alpha: CGFloat) { //функция что выше но сразу делаем все прозрачным
        if alpha <= 1 && 0 <= alpha {
            var allViews = self.subviews
            allViews.append(self)
            for view in allViews {
                view.alpha = alpha
            }
        }
    }


    func setGradient(colorOne: UIColor, colorTwo: UIColor, pointOne: CGPoint, pointTwo: CGPoint) { //делает градиент на вьюшку по направлению
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = pointOne
        gradientLayer.endPoint = pointTwo

        layer.insertSublayer(gradientLayer, at: 0)
    }


    func addSeparator(_ leftOffset: CGFloat = 0, isDown: Bool) {
        let yPoint: CGFloat = isDown ? self.frame.size.height - 0.5 : 0
        let width = wDdevice - leftOffset

        let separatorView = UIView(frame: CGRect(x: leftOffset,
                                                 y: yPoint,
                                                 width: width,
                                                 height: 0.5))

//        separatorView.backgroundColor = SupportClass.Colors.colorSeparator
        self.addSubview(separatorView)
    }
}


