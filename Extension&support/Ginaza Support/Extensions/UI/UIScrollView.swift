//
//  UIScrollView.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

// MARK: - UIScrollView

extension UIScrollView {
    func paralax(constraitArray: [NSLayoutConstraint]) { //паралакс эффект
        let delta: CGFloat = self.contentOffset.y
        if delta < 0 {
            for obj in constraitArray {
                obj.constant = delta
            }
        }
    }

    func paralaxAndNavBar(constraitArray: [NSLayoutConstraint]) { //паралакс эффект
        let delta: CGFloat = self.contentOffset.y

        let startOffset: CGFloat = -1 * SupportClass.indentNavigationBarHeight

        if delta < startOffset {
            for obj in constraitArray {
                obj.constant = -1 * (abs(delta) - abs(startOffset))
            }
        }
    }

    var navigBarScrollEnnable: Bool {
        return self.contentSize.height > SupportClass.Dimensions.hDdevice
    }

    var isZeroPosition: Bool {
        if #available(iOS 11.0, *) {
            return self.contentInsetAdjustmentBehavior == .never
        } else {
            let VC = UIApplication.shared.getWorkVC()
            return !VC.automaticallyAdjustsScrollViewInsets
        }
    }

    func bottomScrollView() {
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        } else {
            UIApplication.shared.getWorkVC().automaticallyAdjustsScrollViewInsets = false
        }
    }
}
