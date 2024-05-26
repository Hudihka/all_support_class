//
//  UIWindow.swift
//  UniversalUtilites
//
//  Created by Худышка К on 26.05.2024.
//

import Foundation
import UIKit

public extension UIWindow {
    static func transitionRoot(
        from: UIWindow?,
        to: UIViewController?,
        duration: TimeInterval,
        completion: ((Bool) -> Void)? = nil
    ) {
        //        //.transitionCurlUp листаем сттраницы
        //        //.transitionCrossDissolve по сути пресент плавный и без анимации
        //        //.transitionFlipFromTop    переворот но не с права на лево а с верху в низ
        //        //.preferredFramesPerSecond60 вообще хрен знает
        
        guard
            let to,
            let from
        else {
            return
        }
        
        UIView.transition(
            with: from,
            duration: duration,
            options: .transitionFlipFromLeft,
            animations: {
                from.rootViewController = to
            },
            completion: completion
        )
    }
}
