//
//  UIView.swift
//  VideoPlayer
//
//  Created by Админ on 19.08.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func cirkleView() {
        let value = min(self.frame.height, self.frame.width)
        
        let radius = value / 2
        self.addRadius(number: radius)
    }
    
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 4
    }
    
    func addShadowCustom(color: UIColor = UIColor.black,
                         size: CGSize,
                         shadowOpacity: Float,
                         radius: CGFloat) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = size
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = radius
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
    
    func circleView(){
        
        let diametr = min(self.frame.height, self.frame.width)
        let radius = diametr / 2
        self.addRadius(number: radius)
        
    }
    
    var screenshot: UIImage {
        return UIGraphicsImageRenderer(size: bounds.size).image { _ in
            drawHierarchy(in: CGRect(origin: .zero, size: bounds.size), afterScreenUpdates: true)
        }
    }
    
}
