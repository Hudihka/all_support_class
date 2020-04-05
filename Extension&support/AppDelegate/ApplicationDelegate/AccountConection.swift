//
//  AccountConection.swift
//  TC5 ЕР
//
//  Created by Username on 03.12.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
//

import Foundation
import UIKit

class AccountConection: NSObject {   ///здесь собраны функции которые необходимо провернуть при авторизации/логауте юзера

    static let shared = AccountConection()

    func playAplication(_ window: UIWindow?) {

        let account = DefaultsUtils.currentAccount()

        if account.isNormAccount {

            if InternetStatus.sharedInstance.isConnectedInternet {
                let VC = RefreshVC.route()
                window?.rootViewController = VC
            } else {
                tabBarVC(window)
            }

        } else {
            registrationVC(window)
        }
    }

//219129

    private func registrationVC(_ window: UIWindow?) {
        let registrVC = Storyboard.registration.getStoryboard().instantiateInitialViewController()
        window?.rootViewController = registrVC
    }

    private func tabBarVC(_ window: UIWindow?) {
        window?.rootViewController = Storyboard.main.getStoryboard().instantiateInitialViewController()
    }

    func logAuht() {
        OTApi.deleteDeviseToken { (_, _) in
            DefaultsUtils.deleteAllKey()
        }

        SupportCoreData.shared.deleteAll(ctx: nil)
        CoreDataManager.shared.changeContext(for: nil)

        //удаление фильтров и серч текста
        ManagerFilters.shared.selectedFilters = [:]
        MainViewController.searchText = nil
        MainViewController.searchTextNotification = nil



        let window: UIWindow? = UIApplication.shared.keyWindow
        let VC = Storyboard.registration.getStoryboard().instantiateInitialViewController()
        window?.transitionRoot(to: VC)

    }

}

