//
//  UIStackView.swift
//  UniversalUtilites
//
//  Created by Худышка К on 26.05.2024.
//

import Foundation
import UIKit

public extension UIStackView {
    
    @discardableResult
    func removeSubviews() -> Self {
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        return self
    }

    @discardableResult
    func addSubviewInStack(_ view: UIView) -> Self {
        addArrangedSubview(view)
        
        return self
    }
    
    @discardableResult
    func customSpacing(_ spacing: CGFloat, after view: UIView) -> Self {
        setCustomSpacing(spacing, after: view)
        return self
    }

    @discardableResult
    func distribution(_ newValue: UIStackView.Distribution) -> Self {
        distribution = newValue
        return self
    }

    @discardableResult
    func alignment(_ newValue: UIStackView.Alignment) -> Self {
        alignment = newValue
        return self
    }

    @discardableResult
    func spacing(_ newValue: CGFloat) -> Self {
        spacing = newValue
        return self
    }
    
    @discardableResult
    func arrangedViews(_ views: UIView...) -> Self {
        views.forEach(addArrangedSubview)
        return self
    }
}
