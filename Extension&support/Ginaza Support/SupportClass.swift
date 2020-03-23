//
//  SupportClass.swift
//  ginzaWindRegistration
//
//  Created by Hudihka on 15/01/2019.
//  Copyright © 2019 Username. All rights reserved.
//

import UIKit

class SupportClass: NSObject {
    enum Dimensions {
        static let hDdevice = UIScreen.main.bounds.size.height
        static let wDdevice = UIScreen.main.bounds.size.width
    }

    static let selfVC: UIViewController? = UIApplication.shared.keyWindow?.visibleViewController

    static func getHKey() -> Int {
        let hDdevice = SupportClass.Dimensions.hDdevice

        //без автокоррекцией
        switch hDdevice {
        case 896: return 267//XMAX
        case 812: return 257//X
        case 736: return 226//7+/8+
        case 667: return 216//7/8
        case 568: return 216//5
        default: return 253
        }
    }

    static func getHKeyAutokorec() -> Int {
        let hDdevice = SupportClass.Dimensions.hDdevice

        //с автокоррекции
        switch hDdevice {
        case 896: return 317//XMAX
        case 812: return 302//X
        case 736: return 271//7+/8+
        case 667: return 260//7/8
        case 568: return 253//5
        default: return 253
        }
    }

    static func isIPhone5() -> Bool {
        return SupportClass.Dimensions.hDdevice == 568
    }

    static func isIPhoneXorXmax() -> Bool {
        return SupportClass.Dimensions.hDdevice >= 812
    }

    static let botomConstrait: CGFloat = SupportClass.isIPhoneXorXmax() ? 39 : 20

    //downConstrait нужен для айфона 5, тк в некоторых случаях кнопка скакала
    static let downConstrait: CGFloat = SupportClass.Dimensions.hDdevice - SupportClass.botomConstrait - 44

    static let zeroFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)

    static let defaultFrameNBar: CGRect = CGRect(x: 0,
                                                 y: SupportClass.isIPhoneXorXmax() ? 44 : 20,
                                                 width: SupportClass.Dimensions.wDdevice,
                                                 height: 44)

    enum Margins {
        static let smallest: CGFloat = 4.0
        static let small: CGFloat = 8.0
        static let mediumSmall: CGFloat = 12.0
        static let medium: CGFloat = 16.0
        static let mediumLarge: CGFloat = 24.0
        static let large: CGFloat = 32.0
        static let extraLarge: CGFloat = 64.0
        static let statusBarHeight: CGFloat = 20.0
        static let navigationBarHeight: CGFloat = SupportClass.isIPhoneXorXmax() ? 64 + 24 : 64
    }

    enum Colors {
        static let textFieldOne = UIColor(red: 151.0 / 255.0, green: 151.0 / 255.0, blue: 151.0 / 255.0, alpha: 1)
        static let buttonContinueColor = UIColor(red: 208.0 / 255.0, green: 88.0 / 255.0, blue: 31.0 / 255.0, alpha: 1)

        static let buttonPressColor = UIColor(red: 176.0 / 255.0, green: 69.0 / 255.0, blue: 18.0 / 255.0, alpha: 1)
        static let labelButtonPressColor = UIColor(red: 206.0 / 255.0, green: 132.0 / 255.0, blue: 96.0 / 255.0, alpha: 1)

        static let circleMapColor = UIColor(red: 100.0 / 255.0, green: 100.0 / 255.0, blue: 100.0 / 255.0, alpha: 16.0 / 100.0)
        static let shadowColorLine = UIColor(red: 100.0 / 255.0, green: 100.0 / 255.0, blue: 100.0 / 255.0, alpha: 1)

        static let bacgroundVCColor = UIColor(red: 40.0 / 255.0, green: 40.0 / 255.0, blue: 40.0 / 255.0, alpha: 1.0)
        static let whiteButtonNavigationBar = UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
        static let barButtonItemAlpha06 = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)

        static let textColorGray = UIColor(red: 145.0 / 255.0, green: 145.0 / 255.0, blue: 145.0 / 255.0, alpha: 1.0)

        static let orangeLogo = UIColor(red: 213.0 / 255.0, green: 91.0 / 255.0, blue: 31.0 / 255.0, alpha: 1.0)

        static let shadowColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.8)
        static let swipeBlockColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.5)

        static let segmentControllNoPress = UIColor(red: 85.0 / 255.0, green: 85.0 / 255.0, blue: 85.0 / 255.0, alpha: 1)

        static let segmentControllPress = UIColor(red: 45.0 / 255.0, green: 45.0 / 255.0, blue: 45.0 / 255.0, alpha: 1)

        static let cellFoodFullName = UIColor(red: 165.0 / 255.0, green: 165.0 / 255.0, blue: 165.0 / 255.0, alpha: 1)
        static let cellOrange = UIColor(red: 215.0 / 255.0, green: 90.0 / 255.0, blue: 11.0 / 255.0, alpha: 1)
        static let cellText = UIColor(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0, alpha: 1)

        static let gradientTwoColor = UIColor(red: 80.0 / 255.0, green: 80.0 / 255.0, blue: 80.0 / 255.0, alpha: 1)

        static let cellPressColor = UIColor(red: 55.0 / 255.0, green: 55.0 / 255.0, blue: 55.0 / 255.0, alpha: 1)
        static let imageCirkle = UIColor(red: 52.0 / 255.0, green: 52.0 / 255.0, blue: 52.0 / 255.0, alpha: 1)

        static let switchIsOff = UIColor(red: 226.0 / 255.0, green: 226.0 / 255.0, blue: 226.0 / 255.0, alpha: 1)
        static let colorSeparator = UIColor(red: 70.0 / 255.0, green: 70.0 / 255.0, blue: 70.0 / 255.0, alpha: 1)

        static let deleteCell = UIColor(red: 31.0 / 255.0, green: 31.0 / 255.0, blue: 31.0 / 255.0, alpha: 1)

        static let clear = UIColor.clear
        static let white = UIColor.white
        static let black = UIColor.black
        static let gray = UIColor(red: 137.0 / 255.0, green: 137.0 / 255.0, blue: 137.0 / 255.0, alpha: 1.0)
        static let green = UIColor(red: 100.0 / 255.0, green: 177.0 / 255.0, blue: 62.0 / 255.0, alpha: 1.0)
        static let backgroundStart = UIColor(red: 232.0 / 255.0, green: 235.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
        static let backgroundEnd = UIColor(red: 246.0 / 255.0, green: 247.0 / 255.0, blue: 248.0 / 255.0, alpha: 1.0)
        static let blueMain = UIColor(red: 6.0 / 255.0, green: 134.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
        static let lightBlue = UIColor(red: 6.0 / 255.0, green: 134.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
        static let errorRed = UIColor(red: 255.0 / 255.0, green: 66.0 / 255.0, blue: 66.0 / 255.0, alpha: 1.0)
        static let blueGray = UIColor(red: 149.0 / 255.0, green: 160.0 / 255.0, blue: 165.0 / 255.0, alpha: 1.0)
        static let messageGray = UIColor(red: 132.0 / 255.0, green: 144.0 / 255.0, blue: 149.0 / 255.0, alpha: 1.0)
        static let tokensPink = UIColor(red: 255.0 / 255.0, green: 88.0 / 255.0, blue: 141.0 / 255.0, alpha: 1.0)
        static let badgeBackground = UIColor(red: 1 / 255, green: 88 / 255, blue: 191 / 255, alpha: 1)
    }
}
