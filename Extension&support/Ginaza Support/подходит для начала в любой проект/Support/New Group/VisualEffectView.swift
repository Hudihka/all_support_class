//
//  VisualEffectView.swift
//  VisualEffectView
//
//  Created by Lasha Efremidze on 5/26/16.
//  Copyright © 2016 Lasha Efremidze. All rights reserved.
//
//swiftlint:disable force_cast

import UIKit

let timeIntervalBlure: TimeInterval = 0.4

/// VisualEffectView is a dynamic background blur view.
open class VisualEffectView: UIVisualEffectView {
    /// Returns the instance of UIBlurEffect.
    private let blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()

    /**
     Tint color.

     The default value is nil.
     */
    open var colorTint: UIColor? {
        get { return _value(forKey: "colorTint") as? UIColor }
        set { _setValue(newValue, forKey: "colorTint") }
    }

    /**
     Tint color alpha.

     The default value is 0.0.
     */
    open var colorTintAlpha: CGFloat {
        get { return _value(forKey: "colorTintAlpha") as! CGFloat }
        set { _setValue(newValue, forKey: "colorTintAlpha") }
    }

    /**
     Blur radius.

     The default value is 0.0.
     */
    open var blurRadius: CGFloat {
        get { return _value(forKey: "blurRadius") as! CGFloat }
        set { _setValue(newValue, forKey: "blurRadius")
            if newValue < 0.1 {
                self.scale = 0.3
            } else if newValue < 0.3 {
                self.scale = 0.6
            } else {
                self.scale = 1
            }}
    }

    /**
     Scale factor.

     The scale factor determines how content in the view is mapped from the logical coordinate space (measured in points) to the device coordinate space (measured in pixels).

     The default value is 1.0.
     */
    private var scale: CGFloat {
        get { return _value(forKey: "scale") as! CGFloat }
        set { _setValue(newValue, forKey: "scale") }
    }

    // MARK: - Initialization

    override public init(effect: UIVisualEffect?) {
        super.init(effect: effect)

        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    private func commonInit() {
        scale = 1
    }

    // MARK: - Helpers

    /// Returns the value for the key on the blurEffect.
    private func _value(forKey key: String) -> Any? {
        return blurEffect.value(forKeyPath: key)
    }

    /// Sets the value for the key on the blurEffect.
    private func _setValue(_ value: Any?, forKey key: String) {
        blurEffect.setValue(value, forKeyPath: key)
        self.effect = blurEffect
    }
}

enum EnumBlureValue {
    case min
    case light
    case midl
    case dark
    case max
}

extension VisualEffectView {
    func blureValue(_ value: EnumBlureValue = .midl) {
        switch value {
        case .midl:
            self.alpha = 1
            self.blurRadius = 5
            self.colorTint = UIColor.black
            self.colorTintAlpha = 0.15

        case .light:

            self.alpha = 1
            self.blurRadius = 1
            self.colorTint = UIColor.black.withAlphaComponent(0.05)
            self.colorTintAlpha = 0.05

        case .dark:

            self.alpha = 1
            self.blurRadius = 1
            self.colorTint = UIColor.black
            self.colorTintAlpha = 0.8

        default:
            self.alpha = value == .min ? 0 : 1
            self.blurRadius = value == .min ? 0 : 10
            self.colorTint = value == .min ? UIColor.clear : UIColor.black
            self.colorTintAlpha = value == .min ? 0 : 0.15
        }
    }

    func blureAt(_ koef: CGFloat) {
        self.alpha = 1 * koef
        self.colorTintAlpha = 0.15 * koef
        self.blurRadius = 10 * koef
    }

    func animationBlure(_ isMax: Bool = true, work:(() -> Void)?, completion:(() -> Void)?) {
        let value: EnumBlureValue = isMax ? .max : .min

        UIView.animate(withDuration: timeIntervalBlure,
                       animations: {
                        self.blureValue(value)
                        guard let work = work else {
                            return
                        }
                        work()
        },
                       completion: { (_) in
                        guard let completion = completion else {
                            return
                        }
                        completion()
        })
    }
}
