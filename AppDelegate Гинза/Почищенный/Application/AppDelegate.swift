//
//  AppDelegate.swift
//  GinzaGO
//
//  Created by Oleg Matveev on 17/01/2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import UIKit

func appDelegateShared() -> AppDelegate {
    return UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private let networkStatus = InternetStatus.sharedInstance //интернет соединение
    private let managersAccount = AccountConection.shared

    var flagPlayOpenAplication = false
    let parserPush = ParserPushNotification()
    var token: String?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //регистрация гугл и фабрики

        self.registerPods()

        //добавить регистрацию пушей
        self.initNotification(application, launchOptions: launchOptions)

        ////откуда начинать запуск

        managersAccount.playAplication(window)

        ////интернет соединение
        networkStatus.startNetwork()
        networkStatus.presentAlertNoInternet()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        ///
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        managersAccount.exsitAplication()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        ApplicationOpportunities.getNotificationActive()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        flagPlayOpenAplication = true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        managersAccount.exsitAplication()
    }
}
