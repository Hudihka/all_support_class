//
//  UIView.swift
//  UniversalUtilites
//
//  Created by Худышка К on 25.05.2024.
//

import Foundation
import UIKit

private var TapActionKey: UInt8 = 0

public extension UIView {
    private var tapAction: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &TapActionKey) as? (() -> Void)
        }
        set {
            objc_setAssociatedObject(self, &TapActionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addTapGestureRecognizer(action: @escaping () -> Void) {
        tapAction = action
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true // Обязательно для распознавания жестов
    }
    
    @objc private func handleTap() {
        tapAction?()
    }
}

public extension UIView {
    var widthView: CGFloat {
        frame.width
    }
    
    var heightView: CGFloat {
        frame.height
    }
    
    func screenshot() -> UIImage {
        UIGraphicsImageRenderer(size: bounds.size).image { _ in
            drawHierarchy(in: CGRect(origin: .zero, size: bounds.size), afterScreenUpdates: true)
        }
    }
    
    var isNotHiden: Bool {
        !isHidden
    }
    
    // MARK: discardableResult
    
    @discardableResult
    func backgroundColor(_ color: UIColor?) -> Self {
        guard let color else {
            return self
        }
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    func background(_ color: UIColor?) -> Self {
        guard let color else {
            return self
        }
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    func setNew(height: CGFloat) -> Self {
        self.frame = CGRect(
            x: self.frame.origin.x,
            y: self.frame.origin.y,
            width: self.frame.size.width,
            height: height
        )
        
        return self
    }
    
    @discardableResult
    func setNew(width: CGFloat) -> Self {
        self.frame = CGRect(
            x: self.frame.origin.x,
            y: self.frame.origin.y,
            width: width,
            height: self.frame.size.height
        )
        
        return self
    }
    
    
    //     func pinEdgesToSuperviewEdges(withOffset offset: CGFloat) {
    //         self.pinEdgesToSuperviewEdges(top: offset, left: offset, bottom: offset, right: offset)
    //     }
    
    //     func pinEdgesToSuperviewEdges(
    //         top: CGFloat = 0,
    //         left: CGFloat = 0,
    //         bottom: CGFloat = 0,
    //         right: CGFloat = 0
    //     ) {
    //         guard let superview = superview else {
    //             return
    //         }
    //         snp.makeConstraints { make in
    //             make.top.equalTo(superview.snp.top).offset(top)
    //             make.bottom.equalTo(superview.snp.bottom).offset(-bottom)
    //             make.left.equalTo(superview.snp.left).offset(left)
    //             make.right.equalTo(superview.snp.right).offset(-right)
    //         }
    //     }
    
    @discardableResult
    func addShadow(
        offset: CGSize = CGSize(width: 0, height: 0),
        opacity: Float = 0.2,
        radius: CGFloat = 4,
        color: UIColor
    ) -> Self {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        
        return self
    }
    
    // закругление нескольких углов вьюшки
    @discardableResult
    func roundedView(rect: UIRectCorner, radius: CGFloat) -> Self {
        let maskPath1 = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: rect, // [.topLeft, .bottomLeft]
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
        
        return self
    }
    
    @discardableResult
    func addRadius(_ number: CGFloat) -> Self  {
        self.layer.cornerRadius = number
        self.layer.masksToBounds = true
        
        return self
    }
    
    @discardableResult
    func addBorder(number: CGFloat, color: UIColor) -> Self {
        layer.borderWidth = number
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        
        return self
    }
    
    @discardableResult
    func cirkleView() -> Self {
        let min = min(frame.height, frame.width)
        let radius = min / 2
        self.addRadius(radius)
        
        return self
    }
    
    func recurrenceAllSubviews() -> [UIView] {// получение всех UIView
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
    
    func opasityAllViews(_ alpha: CGFloat) { // функция что выше но сразу делаем все прозрачным
        if alpha <= 1 && 0 <= alpha {
            var allViews = self.subviews
            allViews.append(self)
            for view in allViews {
                view.alpha = alpha
            }
        }
    }
    
    // делает градиент на вьюшку по направлению
    @discardableResult
    func setGradient(
        colorOne: UIColor,
        colorTwo: UIColor,
        pointOne: CGPoint,
        pointTwo: CGPoint
    ) -> Self {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = pointOne
        gradientLayer.endPoint = pointTwo
        
        layer.insertSublayer(gradientLayer, at: 0)
        
        return self
    }
    
    @discardableResult
    func zeroAlpha() -> Self {
        alpha = 0
        
        return self
    }
    
    @discardableResult
    func oneAlpha() -> Self {
        alpha = 1
        
        return self
    }
    
    @discardableResult
    func setNotHiden(_ isNotHiden: Bool) -> Self  {
        self.isHidden = !isNotHiden
        
        return self
    }
    
    @discardableResult
    func setHiden(_ isHiden: Bool) -> Self  {
        self.isHidden = isHiden
        
        return self
    }
}
