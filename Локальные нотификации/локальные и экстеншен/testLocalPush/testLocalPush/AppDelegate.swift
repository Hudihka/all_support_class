//
//  AppDelegate.swift
//  testLocalPush
//
//  Created by Админ on 05.06.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import UIKit
import UserNotifications
import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (permissionGranted, error) in
            print(error as Any)
        }
        
        let choiceA = UNNotificationAction(identifier: "ross", title: "Ross", options: [.foreground])
        let choiceB = UNNotificationAction(identifier: "chandler", title: "Chandler", options: [.foreground])
        let choiceC = UNNotificationAction(identifier: "joey", title: "Joey", options: [.foreground])
        
        let friendsQuizCategory = UNNotificationCategory(identifier: "UserActionsCategory", actions: [choiceA, choiceB, choiceC], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([friendsQuizCategory])
        UNUserNotificationCenter.current().delegate = self
        
//        initNotification(application, launchOptions: launchOptions)
        
        return true
    }


  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    
      completionHandler([.alert, .sound])
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    
   
    completionHandler()
  }

}
