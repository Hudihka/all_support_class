//
//  UIScrollView.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    func paralax(constraitArray: [NSLayoutConstraint]) { //паралакс эффект
        let delta: CGFloat = self.contentOffset.y
        if delta < 0 {
            for obj in constraitArray {
                obj.constant = delta
            }
        }
    }


    func bottomScrollView() {
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        } else {
            UIApplication.shared.workVC.automaticallyAdjustsScrollViewInsets = false
        }
    }
}
