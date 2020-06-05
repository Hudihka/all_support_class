//
//  AppDelegate.swift
//  testLocalPush
//
//  Created by Админ on 05.06.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initNotification(application, launchOptions: launchOptions)
        
        return true
    }




}

