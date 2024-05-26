//
//  UIEdgeInsets.swift
//  UniversalUtilites
//
//  Created by Худышка К on 26.05.2024.
//

import Foundation
import UIKit

public extension UIEdgeInsets {
    enum Sizes {
        case top(CGFloat)
        case left(CGFloat)
        case bottom(CGFloat)
        case right(CGFloat)
    }
    
    @discardableResult
    func change(_ all: CGFloat) -> Self {
        UIEdgeInsets(top: all, left: all, bottom: all, right: all)
    }
    
    @discardableResult
    func changeHorizontal(_ horizontal: CGFloat) -> Self {
        UIEdgeInsets(
            top: self.top,
            left: horizontal,
            bottom: self.bottom,
            right: horizontal
        )
    }
    
    @discardableResult
    func changeVertical(_ vertical: CGFloat) -> Self {
        UIEdgeInsets(
            top: vertical,
            left: self.left,
            bottom: vertical,
            right: self.right
        )
    }

    @discardableResult
    func change(_ size: Sizes) -> Self {
        switch size {
        case .top(let cGFloat):
            return UIEdgeInsets(
                top: cGFloat,
                left: self.left,
                bottom: self.bottom,
                right: self.right
            )
        case .left(let cGFloat):
            return UIEdgeInsets(
                top: self.top,
                left: cGFloat,
                bottom: self.bottom,
                right: self.right
            )
        case .bottom(let cGFloat):
            return UIEdgeInsets(
                top: self.top,
                left: self.left,
                bottom: cGFloat,
                right: self.right
            )
        case .right(let cGFloat):
            return UIEdgeInsets(
                top: self.top,
                left: self.left,
                bottom: self.bottom,
                right: cGFloat
            )
        }
    }
    
    @discardableResult
    func change(_ sizes: [Sizes]) -> Self {
        var top: CGFloat = 0
        var left: CGFloat = 0
        var bottom: CGFloat = 0
        var right: CGFloat = 0

        sizes.forEach({
            switch $0 {
            case .top(let cGFloat):
                top = cGFloat
            case .left(let cGFloat):
                left = cGFloat
            case .bottom(let cGFloat):
                bottom = cGFloat
            case .right(let cGFloat):
                right = cGFloat
            }
        })
        
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}
