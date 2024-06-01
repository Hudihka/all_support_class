//
//  UIButton.swift
//  UniversalUtilites
//
//  Created by Худышка К on 26.05.2024.
//

import Foundation
import UIKit

private var ActionKey: UInt8 = 0

public extension UIButton {
    private var action: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &ActionKey) as? (() -> Void)
        }
        set {
            objc_setAssociatedObject(self, &ActionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @discardableResult
    func addAction(
        for controlEvents: UIControl.Event = .touchUpInside,
        _ closure: @escaping () -> Void
    ) -> Self {
        action = closure
        addTarget(self, action: #selector(triggerAction), for: controlEvents)
        
        return self
    }
    
    @objc private func triggerAction() {
        action?()
    }
}

public extension UIButton {
    @discardableResult
    func title(_ value: String, for state: UIControl.State = .normal) -> Self {
        setTitle(value, for: state)
        return self
    }

    @discardableResult
    func image(_ image: UIImage?, for state: UIControl.State = .normal) -> Self {
        setImage(image, for: state)
        return self
    }

    @discardableResult
    func backgroundImage(_ image: UIImage?, for state: UIControl.State = .normal) -> Self {
        setBackgroundImage(image, for: state)
        return self
    }

    @discardableResult
    func titleColor(_ color: UIColor, for state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }

    @discardableResult
    func titleFont(_ newValue: UIFont?) -> Self {
        titleLabel?.font = newValue
        return self
    }
    
    @discardableResult
    func setContentEdgeInsets(_ contentEdgeInsets: UIEdgeInsets) -> Self {
        self.contentEdgeInsets = contentEdgeInsets
        return self
    }
    
    @discardableResult
    func setEnable(_ enable: Bool) -> Self {
        self.isEnabled = enable
        return self
    }
}
