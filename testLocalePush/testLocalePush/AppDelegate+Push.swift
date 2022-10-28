//
//  AppDelegate+Push.swift
//  testLocalePush
//
//  Created by Админ on 21.05.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

extension AppDelegate: UNUserNotificationCenterDelegate {


    func initLocalNotification(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {

        registerForPushes(application)

    }

    private func registerForPushes(_ application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        
        // request permission from user to send notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: { authorized, error in
          if authorized {
            DispatchQueue.main.async(execute: {
                application.registerForRemoteNotifications()
            })
          }
        })
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        NotificationCenter.default.post(name: NSNotification.Name("Сработал локальный пуш"), object: nil)
        
      print("пуш сработал на переднем плане")
      completionHandler([.alert, .sound])
    }
      
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    
     print("нажатие на пуш")
        
//        //если хотим разлечать на переднем или заднем плане
//        if(application.applicationState == .active){
//          print("user tapped the notification bar when the app is in foreground")
//
//        }
//
//        if(application.applicationState == .inactive)
//        {
//          print("user tapped the notification bar when the app is in background")
//        }
      
      completionHandler()
    }
    
    

    
}
