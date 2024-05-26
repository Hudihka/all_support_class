//
//  UIClosureButton.swift
//  UniversalUtilites
//
//  Created by Худышка К on 26.05.2024.
//

import Foundation
import UIKit

class UIClosureButton: UIButton {
    private var action: (() -> Void)?

    convenience init(action: @escaping () -> Void) {
        self.init(frame: .zero)
        self.action = action
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    @objc 
    private func buttonPressed() {
        action?()
    }
}
