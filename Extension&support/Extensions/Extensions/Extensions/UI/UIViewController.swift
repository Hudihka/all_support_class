//
//  UIViewController.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func buttonback(_ title: String? = nil, vc: UIViewController) { //сл вью контроллер будет с кнопкой назад или другим титульником
        self.navigationController?.pushViewController(vc, animated: true)
        let textTitle = title ?? "Назад"
        let backButton: UIBarButtonItem = UIBarButtonItem(title: textTitle, style: .bordered, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }

    //методы необходимые для суппорт вью контроллера(добавить тень/сделать прозрачным итд)
    func atributesColorNavigBar(color: UIColor) {
        self.navigationController?.navigationBar.tintColor = color

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    }


    func clearNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }

    func alphaAllObj(alpha: Float) { //делает все обьекты на вью контроллере прозрачными(кроме блюра и вью)

        for view in self.view.recurrenceAllSubviews {
            view.alpha = CGFloat(alpha)
        }
    }

    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }

    func customTransition(VC: UIViewController?) {  //кастомная анимация
        if let VC = VC {
            self.view.window?.transitionRoot(to: VC)
        }
    }

    var lastPushVC: UIViewController? { //получаем последний запушенный вью конроллер в стеке

        if let TBVC = self.presentingViewController as? UITabBarController {
            let index = TBVC.selectedIndex
            if let NVC = TBVC.viewControllers?[index] as? UINavigationController {
                if let lastVc = NVC.topViewController {
                    return lastVc
                }
            }
        }

        if let navigStack = self.stackVC?.last {
            return navigStack
        }

        return nil
    }

    private var stackVC: [UIViewController]? { //выдает стек вью контроллеров когда нет таб бара
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if let viewControllers = appDelegate.window?.rootViewController?.children {
                return viewControllers
            }
        }

        return nil
    }

}
