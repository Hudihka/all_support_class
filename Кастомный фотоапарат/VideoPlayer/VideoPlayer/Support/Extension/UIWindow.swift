//
//  UIWindow.swift
//  VideoPlayer
//
//  Created by Админ on 19.08.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import UIKit

extension UIWindow {
    func transitionRoot(to: UIViewController){
        UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            self.rootViewController = to
        })
    }

    var visibleViewController: UIViewController? {  //UIApplication.shared.keyWindow?.visibleViewController получить активный ВК
        return UIWindow.getVisibleViewControllerFrom(self.rootViewController)
    }

    static func getVisibleViewControllerFrom(_ vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
}

