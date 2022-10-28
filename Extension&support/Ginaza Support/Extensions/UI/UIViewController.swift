//
//  UIViewController.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

extension UIViewController {
    func presentAlertAPay() {
        let textTitle = "Оплата не удалась"
        let textMessage = "Выберите другую карту"

        let textOk = "ОК"

        let alert = UIAlertController(title: textTitle, message: textMessage, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: textOk, style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func isZeroCartInAccount() -> Bool { //выдает да если 0 карт у аккаунта или нет активной
        if self.countCard() == 0 {
            return true
        }
        guard let myAccountCard = DefaultsUtils.currentAccount()?.getCartAccaunt() else {
            return true
        }
        return myAccountCard.filter({ $0.isActive == true }).isEmpty
    }

    func someCard() -> Bool { //есть ли активная карта
        if let myAccountCartds = DefaultsUtils.currentAccount()?.getCartAccaunt() {
            return !myAccountCartds.filter({ $0.isActive ?? false }).isEmpty
        }

        return false
    }

    func countCard() -> Int { //сколько карт у аккаунта
        if let myAccount = DefaultsUtils.currentAccount() {
            return myAccount.getCartAccaunt().count
        }
        return 0
    }

    func isApplePayActiveCard() -> Bool { //выдает YES если активная карта эпл пей

        if let myAccountCartds = DefaultsUtils.currentAccount()?.getCartAccaunt() {
            return !myAccountCartds.filter({ $0.isActive ?? false && $0.isCardAPay }).isEmpty
        }

        return false
    }

    func buttonback(_ title: String? = nil, vc: UIViewController) { //сл вью контроллер будет с кнопкой назад или другим титульником
        self.navigationController?.pushViewController(vc, animated: true)
        let textTitle = title ?? "Назад"
        let backButton: UIBarButtonItem = UIBarButtonItem(title: textTitle, style: .bordered, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }

    func addshadow(view: UIView, viewW: Double, viewH: Double) {//тень на 3х сторонах
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = 4.0
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = SupportClass.Colors.shadowColor.cgColor

        let path = UIBezierPath()

        // Move to the Bottom Right Corner
        path.move(to: CGPoint(x: viewW, y: viewH + 5))

        // Move to the Bottom Left Corner
        path.addLine(to: CGPoint(x: 0.0, y: viewH + 5))

        // Start at the Top Left Corner
        path.addLine(to: CGPoint(x: 0.0, y: 10))

        // This is the extra point in the middle :) Its the secret sauce.
        path.addLine(to: CGPoint(x: viewW / 2, y: viewH / 2))

        // Move to the Top Right Corner
        path.addLine(to: CGPoint(x: viewW, y: 10))

        path.close()

        view.layer.shadowPath = path.cgPath
    }

    func titleColorWhite(scrollView: UIScrollView) { //динамический белый цвет
        let currentOffset = scrollView.contentOffset.y

        if currentOffset >= 0 && currentOffset <= 100 {
            var alpha: CGFloat = (100 - currentOffset) / 100
            if currentOffset > 100 {
                alpha = 0.0
            }

            let color = UIColor(red: 1, green: 1, blue: 1, alpha: alpha)
            let textAttributes = [NSAttributedString.Key.foregroundColor: color]
            self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        } else if currentOffset > 100 {
            let color = UIColor.clear
            let textAttributes = [NSAttributedString.Key.foregroundColor: color]
            self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        }
    }

    func presentBlure(option: PlayBlureVC) {
        guard let VC = BlureViewController.route() else {
            return
        }
        VC.settingsPlay = option
        self.present(VC, animated: false, completion: nil)
    }

    func stackVC() -> [UIViewController] { //выдает стек вью контроллеров
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if let viewControllers = appDelegate.window?.rootViewController?.children {
                // Array of all viewcontroller after push
                print(viewControllers)
                return viewControllers
            }
        }

        return []
    }
    //методы необходимые для суппорт вью контроллера(добавить тень/сделать прозрачным итд)
    func atributesColorNavigBar(color: UIColor) {
        self.navigationController?.navigationBar.tintColor = color

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    }

    func addImageShadow () {
        let yHeigt: CGFloat = SupportClass.indentNavigationBarHeight
        let viewImage = UIView(frame: CGRect(x: 0,
                                             y: yHeigt,
                                             width: SupportClass.Dimensions.wDdevice,
                                             height: 0.5))

        viewImage.backgroundColor = SupportClass.Colors.shadowColorLine
        self.view.addSubview(viewImage)
    }

    func clearNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }

    func alphaAllObj(alpha: Float) { //делает все обьекты на вью контроллере прозрачными(кроме блюра и вью)

        for view in self.view.recurrenceAllSubviews() {
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
}
