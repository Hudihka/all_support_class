//
//  SupportBBItems.swift
//  GinzaGO
//
//  Created by Username on 11.04.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import UIKit

enum ImageBBItems: String {
    case goChangeProfile  = "barButtonProfileVC"
    case callBBItem       = "ShapeBBItem"
    case support          = "supportBBItem"
    case leftBack         = "backBBItem"
}

enum EnumTitle: String {
    case titleMyOrders  = "Мои заказы"
    case titleInfoorder = "Информация о заказе"
    case stockTitle     = "Акции"
    case editUsers      = "Редактировать профиль"
    case profile        = "Профиль"
    case billingInfo    = "Платежная информация"
    case settiings      = "Настройки"
    case dopInfo        = "Дополнительно"
    case dopInfoCompanu = "О компании"
    case fAQtitile      = "Частые вопросы"
    case check          = "Отправка чека"
    case chat           = "Онлайн-чат"
    case titleVC        = "Задать вопрос"
    case reviewsVC      = "Оставить отзывы"
    case salleProcent   = "Размер скидки Спасибо"
}

//extension MainViewController {

//    func getBBItem(_ tupe: ImageBBItems) -> UIBarButtonItem {
//        let image = UIImage(named: tupe.rawValue) ?? UIImage()
//
//        switch tupe {
//        case .support:
//            return UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(goSupportPupap))
//
//        case .goChangeProfile:
//            return UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(goChangeProfile))
//
//        case .callBBItem:
//            return UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(callSelector))
//
//        case .leftBack:
//            return UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(back))
//        }
//    }
//
//    @objc func callSelector() {
//        Utils.call(phone: "84950231100")
//    }
//
//    @objc func goChangeProfile() {
//        if let userData = UserDataSetupVC.route(account: DefaultsUtils.currentAccount()) {
//            self.buttonback(vc: userData)
//        }
//    }
//
//    @objc func goSupportPupap() {
//        if let vc = ChatViewController.route() {
//            self.buttonback(vc: vc)
//        }
//    }
//
//    @objc func back() {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    func settingsNavigBar() {
//        addRightBBitem()
//        addTitle()
//    }
//
//    private func addRightBBitem() {
//        if self is StockViewController || self is FoodViewController ||
//            self is OrdersViewController || self is SpecialStockVC ||
//            self is MenuViewController || self is StockInformationVC {
//            navigationItem.rightBarButtonItem = self.getBBItem(.support)
//            return
//        } else if self is ChatViewController {
//            navigationItem.rightBarButtonItem = self.getBBItem(.callBBItem)
//            return
//        } else if self is ProfileViewController {
//            navigationItem.rightBarButtonItems = [self.getBBItem(.goChangeProfile), self.getBBItem(.support)]
//            return
//        }
//    }
//
//    func addTitle() {
//        switch self {
//        case is OrdersViewController:
//            self.title = EnumTitle.titleMyOrders.rawValue
//
//        case is InfoOrderVC:
//            self.title = EnumTitle.titleInfoorder.rawValue
//
//        case is StockViewController:
//            self.title = EnumTitle.stockTitle.rawValue
//
//        case is UserDataSetupVC:
//            self.title = EnumTitle.editUsers.rawValue
//
//        case is OrdersViewController:
//            self.title = EnumTitle.titleMyOrders.rawValue
//
//        case is ProfileViewController:
//            self.title = EnumTitle.profile.rawValue
//
//        case is BillingInformationVC:
//            self.title = EnumTitle.billingInfo.rawValue
//
//        case is SettingsUserVC:
//            self.title = EnumTitle.settiings.rawValue
//
//        case is AdditionalInfoVC:
//            self.title = EnumTitle.dopInfo.rawValue
//
//        case is AboutCompanyVC:
//            self.title = EnumTitle.dopInfoCompanu.rawValue
//
//        case is FAQViewController:
//            self.title = EnumTitle.fAQtitile.rawValue
//
//        case is SendingCheckVC:
//            self.title = EnumTitle.check.rawValue
//
//        case is ChatViewController:
//            self.title = EnumTitle.chat.rawValue
//
//        case is CheckoutTextVC:
//            self.title = EnumTitle.titleVC.rawValue
//
//        case is RewievsVC:
//            self.title = EnumTitle.reviewsVC.rawValue
//
//        case is ThanksSBVC:
//            self.title = EnumTitle.salleProcent.rawValue
//
//        default:
//            break
//        }
//    }
//}
