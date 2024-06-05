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
    enum Side: CaseIterable {
        case top
        case bottom
        case leading
        case trailing
    }
    
    @discardableResult
    func changePositionOnSuperview(edge: UIEdgeInsets) -> Self {
        guard let superview = superview else {
            return self
        }
        snp.makeConstraints {
            $0.top.equalToSuperview().inset(edge.top)
            $0.bottom.equalToSuperview().inset(edge.bottom)
            $0.leading.equalToSuperview().inset(edge.left)
            $0.trailing.equalToSuperview().inset(edge.right)
        }
        
        return self
    }
    
    @discardableResult
    func addOn(view: UIView, to edge: UIEdgeInsets) -> Self {
        self.addSubview(view)
        
        view.snp.makeConstraints {
            $0.top.equalToSuperview().inset(edge.top)
            $0.bottom.equalToSuperview().inset(edge.bottom)
            $0.leading.equalToSuperview().inset(edge.left)
            $0.trailing.equalToSuperview().inset(edge.right)
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
            $0.leading.equalToSuperview().inset(edge.left)
            $0.trailing.equalToSuperview().inset(edge.right)
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
    
    @discardableResult
    func addOnEqualToSuperview(view: UIView, withOut: Side..., compl: (ConstraintMaker) -> Void) -> Self {
        self.addSubview(view)
        
        let need = Side.allCases.filter({ !withOut.contains($0) })
        
        view.snp.makeConstraints { make in
            
            need.forEach({
                switch $0 {
                case .bottom:
                    make.bottom.equalToSuperview()
                case .top:
                    make.top.equalToSuperview()
                case .leading:
                    make.leading.equalToSuperview()
                case .trailing:
                    make.trailing.equalToSuperview()
                }
            })
            
            compl(make)
        }
        
        return self
    }
    
    @discardableResult
    func addOnEqualToSuperview(view: UIView, withOut: Side...) -> Self {
        self.addSubview(view)
        
        let need = Side.allCases.filter({ !withOut.contains($0) })
        
        view.snp.makeConstraints { make in
            
            need.forEach({
                switch $0 {
                case .bottom:
                    make.bottom.equalToSuperview()
                case .top:
                    make.top.equalToSuperview()
                case .leading:
                    make.leading.equalToSuperview()
                case .trailing:
                    make.trailing.equalToSuperview()
                }
            })
        }
        
        return self
    }
    
    @discardableResult
    func addOnEqualToSuperview(withOut: Side..., compl: (ConstraintMaker) -> Void) -> Self {
        let need = Side.allCases.filter({ !withOut.contains($0) })
        
        self.snp.makeConstraints { make in
            
            need.forEach({
                switch $0 {
                case .bottom:
                    make.bottom.equalToSuperview()
                case .top:
                    make.top.equalToSuperview()
                case .leading:
                    make.leading.equalToSuperview()
                case .trailing:
                    make.trailing.equalToSuperview()
                }
            })
            
            compl(make)
        }
        
        return self
    }
    
    @discardableResult
    func addOnEqualToSuperview(withOut: Side...) -> Self {
        let need = Side.allCases.filter({ !withOut.contains($0) })
        
        self.snp.makeConstraints { make in
            
            need.forEach({
                switch $0 {
                case .bottom:
                    make.bottom.equalToSuperview()
                case .top:
                    make.top.equalToSuperview()
                case .leading:
                    make.leading.equalToSuperview()
                case .trailing:
                    make.trailing.equalToSuperview()
                }
            })
        }
        
        return self
    }
}
