//
//  UIFont.swift
//  UniversalUtilites
//
//  Created by Худышка К on 26.05.2024.
//

import Foundation
import UIKit

extension UIFont {
    enum EnumFont {
        case bold(CGFloat)
        case semibold(CGFloat)
        case regular(CGFloat)
        case medium(CGFloat)
        case light(CGFloat)
    }
    
    static func initFont(type: EnumFont) -> UIFont {
        type.font
    }
}

private extension UIFont.EnumFont {
    
    private var wedding: UIFont.Weight {
        switch self {
        case .bold:
            return UIFont.Weight.bold

        case .semibold:
            return UIFont.Weight.semibold

        case .regular:
            return UIFont.Weight.regular

        case .medium:
            return UIFont.Weight.medium

        case .light:
            return UIFont.Weight.light
        }
    }

    var font: UIFont {
        switch self {
        case .bold(let size):
            return UIFont.systemFont(ofSize: size, weight: wedding)

        case .semibold(let size):
            return UIFont.systemFont(ofSize: size, weight: wedding)

        case .regular(let size):
            return UIFont.systemFont(ofSize: size, weight: wedding)

        case .medium(let size):
            return UIFont.systemFont(ofSize: size, weight: wedding)

        case .light(let size):
            return UIFont.systemFont(ofSize: size, weight: wedding)
        }
    }
}
