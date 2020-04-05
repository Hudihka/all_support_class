//
//  AppDelegate.swift
//  TC5 ЕР
//
//  Created by Username on 03.12.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
//

import UIKit

var appDelegateShared: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var token: String = "нет_токена"

    var flagPlayOpenAplication = false
    let parserPush = ParserPushNotification()

    private let managersAccount = AccountConection.shared
    private let networkStatus = InternetStatus.sharedInstance //интернет соединение

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        
        initNotification(application, launchOptions: launchOptions)

        CoreDataManager.shared.initialize()

        //интернет соединение
        networkStatus.startNetwork()

        managersAccount.playAplication(window)

        //Удаление старых файлов
        SaveImageDirectory.shared.removeFrieDayObject(countSeconds: 3600 * 24 * 5)

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataManager.shared.save()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        ApplicationOpportunities.getNotificationActive()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        flagPlayOpenAplication = true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.shared.save()
    }


    //MARK: - ORIENTATION

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {

        if let rootViewController = self.topViewControllerWithRootViewController(rootViewController: window?.rootViewController) {
            if (rootViewController.responds(to: Selector(("canRotate")))), WebViewVC.activeWebVC {
                return .allButUpsideDown
            }
        }

        return .portrait
    }

    private func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
        if (rootViewController == nil) { return nil }

        if (rootViewController.isKind(of: UITabBarController.self)) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UITabBarController).selectedViewController)
        } else if (rootViewController.isKind(of: UINavigationController.self)) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UINavigationController).visibleViewController)
        } else if (rootViewController.presentedViewController != nil) {
            return topViewControllerWithRootViewController(rootViewController: rootViewController.presentedViewController)
        }
        return rootViewController
    }


}

