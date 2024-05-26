//
//  UIImageView.swift
//  UniversalUtilites
//
//  Created by Худышка К on 26.05.2024.
//

import Foundation
import UIKit

public extension UIImageView {
    @discardableResult
    func setImage(_ image: UIImage?) -> Self {
        self.image = image
        
        return self
    }
    
    @discardableResult
    func setContentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        
        return self
    }
}
