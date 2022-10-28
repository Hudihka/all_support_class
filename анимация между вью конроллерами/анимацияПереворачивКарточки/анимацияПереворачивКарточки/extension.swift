//
//  extension.swift
//  анимацияПереворачивКарточки
//
//  Created by Hudihka on 18/08/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import Foundation
import UIKit


extension UIWindow {
    func transitionRoot(to: UIViewController){

        //.transitionFlipFromLeft

        //.transitionCurlUp листаем сттраницы
        //.transitionCrossDissolve по сути пресент плавный и без анимации
        //.transitionFlipFromTop    переворот но не с права на лево а с верху в низ
        //.preferredFramesPerSecond60 вообще хрен знает

        UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            self.rootViewController = to
        })
    }
}

extension UIViewController {

    func transition(VC: UIViewController) {
        self.view.window?.transitionRoot(to: VC)
    }

}
