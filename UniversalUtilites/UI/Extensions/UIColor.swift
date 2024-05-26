//
//  UIColor.swift
//  UniversalUtilites
//
//  Created by Худышка К on 25.05.2024.
//

import Foundation
import UIKit

public extension UIColor {
    convenience init(hex: String, alpha: CGFloat? = nil) {
        let r, g, b, a: CGFloat

        var mutableString = hex

        if hex.count == 7 {
            mutableString.append("FF")
        }

        if hex.hasPrefix("#") {
            let start = mutableString.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(mutableString[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = alpha ?? CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        self.init(white: 1, alpha: 0)
    }
}
