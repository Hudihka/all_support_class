//
//  UIView.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

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

    func add3shadow(viewW: Double, viewH: Double) {//тень на 3х сторонах
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = SupportClass.Colors.shadowColor.cgColor

        let path = UIBezierPath()

        // Move to the Bottom Right Corner
        path.move(to: CGPoint(x: viewW, y: viewH + 5))

        // Move to the Bottom Left Corner
        path.addLine(to: CGPoint(x: 0.0, y: viewH + 5))

        // Start at the Top Left Corner
        path.addLine(to: CGPoint(x: 0.0, y: 10))

        // This is the extra point in the middle :) Its the secret sauce.
        path.addLine(to: CGPoint(x: viewW / 2, y: viewH / 2))

        // Move to the Top Right Corner
        path.addLine(to: CGPoint(x: viewW, y: 10))

        path.close()

        self.layer.shadowPath = path.cgPath
    }

    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = SupportClass.Colors.shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4.0
    }

    func addShadowClear() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = SupportClass.Colors.shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 2.5
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

    func addshadowDown() {//тень в верху

        let viewW = self.frame.width

        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = SupportClass.Colors.shadowColor.cgColor

        let path = UIBezierPath()

        path.move(to: CGPoint(x: 0, y: -10))

        path.addLine(to: CGPoint(x: viewW / 2, y: 16))

        path.addLine(to: CGPoint(x: viewW, y: -10))

        path.close()

        self.layer.shadowPath = path.cgPath
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

    func rotate() { //вращать бесконечно
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1.3
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }

    func addSeparator(_ leftOffset: CGFloat = 0, isDown: Bool) {
        let yPoint: CGFloat = isDown ? self.frame.size.height - 0.5 : 0
        let width = SupportClass.Dimensions.wDdevice - leftOffset

        let separatorView = UIView(frame: CGRect(x: leftOffset,
                                                 y: yPoint,
                                                 width: width,
                                                 height: 0.5))

        separatorView.backgroundColor = SupportClass.Colors.colorSeparator
        self.addSubview(separatorView)
    }
}

class TouchthruView: UIView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for view in self.subviews {
            if view.isHidden {
                continue
            }
            if view.bounds.contains(view.convert(point, from: self)) {
                return true
            }
        }
        return false
    }
}
