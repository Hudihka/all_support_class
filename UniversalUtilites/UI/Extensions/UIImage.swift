//
//  UIImage.swift
//  UniversalUtilites
//
//  Created by Худышка К on 26.05.2024.
//

import Foundation
import UIKit

public extension UIImage {
    @discardableResult
    func titntColor(_ color: UIColor?) -> Self {
        guard let color else {
            return self
        }
        
        self.withTintColor(color, renderingMode: .alwaysOriginal)

        return self
    }
}
