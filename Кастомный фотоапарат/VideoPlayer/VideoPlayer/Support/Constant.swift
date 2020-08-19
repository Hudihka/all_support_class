//
//  Constant.swift
//  VideoPlayer
//
//  Created by Админ on 19.08.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import Foundation
import UIKit


let hDevice = UIScreen.main.bounds.size.height
let wDevice = UIScreen.main.bounds.size.width


var isIPhone5: Bool {
    return hDevice == 568
}

var isIPhoneXorXmax: Bool {
    return hDevice >= 812
}

var indentNavigationBarHeight: CGFloat {
    return statusBarHeight + navigBarHeight //88 : 64
}

var statusBarHeight: CGFloat{
    return isIPhoneXorXmax ? 44 : 20
}

let navigBarHeight: CGFloat = 44


var heightTabBar: CGFloat {
    return isIPhoneXorXmax ? 84 : 58
}


