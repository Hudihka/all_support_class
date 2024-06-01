//
//  UIView+SnapKit.swift
//  UniversalUtilites
//
//  Created by Худышка К on 26.05.2024.
//

import Foundation
import SnapKit
import UIKit

public extension UIView {
    @discardableResult
    func changePositionOnSuperview(edge: UIEdgeInsets) -> Self {
        guard let superview = superview else {
            return self
        }
        snp.makeConstraints {
            $0.top.equalToSuperview().inset(edge.top)
            $0.bottom.equalToSuperview().inset(edge.bottom)
            $0.left.equalToSuperview().inset(edge.left)
            $0.right.equalToSuperview().inset(edge.right)
        }
        
        return self
    }
    
    @discardableResult
    func addOn(view: UIView, to edge: UIEdgeInsets) -> Self {
        self.addSubview(view)
        
        view.snp.makeConstraints {
            $0.top.equalToSuperview().inset(edge.top)
            $0.bottom.equalToSuperview().inset(edge.bottom)
            $0.left.equalToSuperview().inset(edge.left)
            $0.right.equalToSuperview().inset(edge.right)
        }
        
        return self
    }
    
    @discardableResult
    func addOn(view: UIView) -> Self {
        self.addSubview(view)
        
        view.snp.makeConstraints {
            $0.top.bottom.right.left.equalToSuperview()
        }
        
        return self
    }
    
    @discardableResult
    func addOnWith(edge: UIEdgeInsets) -> Self {
        self.snp.makeConstraints {
            $0.top.equalToSuperview().inset(edge.top)
            $0.bottom.equalToSuperview().inset(edge.bottom)
            $0.left.equalToSuperview().inset(edge.left)
            $0.right.equalToSuperview().inset(edge.right)
        }
        
        return self
    }
    
    @discardableResult
    func addOnEqualToSuperview() -> Self {
        self.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        return self
    }
}
