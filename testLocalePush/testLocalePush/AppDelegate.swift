//
//  AppDelegate.swift
//  testLocalePush
//
//  Created by Админ on 20.05.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (grand, error) in
            if grand {
                print("finish")
            }
        }
        
        
        return true
    }




}

