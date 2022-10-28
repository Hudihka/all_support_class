//
//  AppDelegate.swift
//  Notifications
//
//  Created by Alexey Efimov on 21.06.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notifications = Notifications() //наш класс для нотификаций

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        notifications.requestAutorization()                         //сообщаем что наше приложение теперь принимает нотификации
        notifications.notificationCenter.delegate = notifications
        return true
    }

    

    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0         //сбрасываем бейдж до нуля
    }
    
    

}
