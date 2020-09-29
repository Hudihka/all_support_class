//
//  SupportClass.swift
//  ginzaWindRegistration
//
//  Created by Hudihka on 15/01/2019.
//  Copyright © 2019 Username. All rights reserved.
//

import UIKit


let hDdevice = UIScreen.main.bounds.size.height
let wDdevice = UIScreen.main.bounds.size.width

let timeInterval: TimeInterval = 0.2

var isIPhone5: Bool {
    return hDdevice == 568
}

var isIPhoneXorXmax: Bool {
    return hDdevice >= 812
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

func rectNavigationBar(_ defaultPosition: Bool) -> CGRect {
	
	let yPosition = defaultPosition ? statusBarHeight : -1 * navigBarHeight
	
	let defaultFrameNBar: CGRect = CGRect(x: 0,
										  y: yPosition,
										  width: wDdevice,
										  height: navigBarHeight)
	
	return defaultFrameNBar
	
}

