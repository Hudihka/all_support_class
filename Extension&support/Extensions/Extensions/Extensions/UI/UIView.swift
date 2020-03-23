//
//  UIView.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
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
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4
    }

    func addDopShadow(){
        let viewShadow = UIView(frame: self.frame)
        viewShadow.center = self.center
        viewShadow.backgroundColor = UIColor.yellow
        viewShadow.layer.shadowColor = UIColor.red.cgColor
        viewShadow.layer.shadowOpacity = 1
        viewShadow.layer.shadowOffset = CGSize.zero
        viewShadow.layer.shadowRadius = 5
        self.addSubview(viewShadow)
    }

    func addShadowTabBar(){
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.7
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

    var recurrenceAllSubviews: [UIView] {//получение всех UIView
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
    
//поиск вью определенного класса
//	ub_firstSubView(ofType: UIScrollView.self)
    
    func ub_firstSubView<T: UIView>(ofType type: T.Type) -> T? {
        var resultView: T?
        for view in subviews {
            if let view = view as? T {
                resultView = view
                break
            }
            else {
                if let foundView = view.ub_firstSubView(ofType: T.self) {
                    resultView = foundView
                    break
                }
            }
        }
        return resultView
    }

    var recurrenceAllSubviewsZeroTag: [UIView] {//получение всех UIView

        return recurrenceAllSubviews.filter({$0.tag == 0})
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


    func addSeparator(_ leftOffset: CGFloat = 18, isDown: Bool) {
        let yPoint: CGFloat = isDown ? self.frame.size.height - 0.5 : 0
        let width = wDdevice - leftOffset

        let separatorView = UIView(frame: CGRect(x: leftOffset,
                                                 y: yPoint,
                                                 width: width,
                                                 height: 0.5))

        separatorView.backgroundColor = separator
        self.addSubview(separatorView)
    }


    var screenshot: UIImage {
        if #available(iOS 10.0, *) {
            return UIGraphicsImageRenderer(size: bounds.size).image { _ in
                drawHierarchy(in: CGRect(origin: .zero, size: bounds.size), afterScreenUpdates: true)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
            drawHierarchy(in: self.bounds, afterScreenUpdates: true)
            let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
            UIGraphicsEndImageContext()
            return image
        }
    }
}


