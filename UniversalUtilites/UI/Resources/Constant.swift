//
//  Constant.swift
//  UniversalUtilites
//
//  Created by Худышка К on 26.05.2024.
//

import Foundation
import UIKit

let hDevice = UIScreen.main.bounds.size.height
let wDevice = UIScreen.main.bounds.size.width

var isIPhoneWithBang: Bool {
    UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
}

let statusBarHeight: CGFloat = isIPhoneWithBang ? 44 : 20
let navigationBarHeight: CGFloat = 44
let heightTabBar: CGFloat = isIPhoneWithBang ? 84 : 49
let indentNavigationBarHeight: CGFloat = statusBarHeight + navigationBarHeight // 88 : 64
let bottomSafeArea: CGFloat = isIPhoneWithBang ? 35 : 20

enum Constant {
    enum Layout {
//        static let offset16: CGFloat = 16
    }
}
