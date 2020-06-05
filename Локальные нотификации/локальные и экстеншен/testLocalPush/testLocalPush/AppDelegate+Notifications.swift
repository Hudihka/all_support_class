//
//  Notifications.swift
//  GinzaGO
//
//  Created by Username on 27.08.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

//extension AppDelegate: UNUserNotificationCenterDelegate {
    
//
//    func initNotification(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
//
//        registerForPushes(application)
//        application.registerForRemoteNotifications()
//
//        self.openPushAplication(launchOptions)
//
//
//        //локальные пуши
//        let choiceA = UNNotificationAction(identifier: "ross", title: "Ross", options: [.foreground])
//        let choiceB = UNNotificationAction(identifier: "chandler", title: "Chandler", options: [.foreground])
//        let choiceC = UNNotificationAction(identifier: "joey", title: "Joey", options: [.foreground])
//
//        let friendsQuizCategory = UNNotificationCategory(identifier: "userActionsCategory", actions: [choiceA, choiceB, choiceC], intentIdentifiers: [], options: [])
//
//        UNUserNotificationCenter.current().setNotificationCategories([friendsQuizCategory])
//
//    }
//
//    private func registerForPushes(_ application: UIApplication) {
//
//        UNUserNotificationCenter.current().delegate = self
//        let arraySettings: UNAuthorizationOptions = [.alert, .sound, .badge]
//
//        UNUserNotificationCenter.current().requestAuthorization(options: arraySettings) { (granted, _) in
//            print("Permission granted: \(granted)")
//
//            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
//                print("Notification settings: \(settings)")
//                //2//4
//                DispatchQueue.main.async {
//                    guard settings.authorizationStatus == .authorized else {
//                        return
//                    }
//                    UIApplication.shared.registerForRemoteNotifications()
//                }
//            }
//        }
//    }
//
//    private func openPushAplication(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
//        if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
//            DispatchQueue.main.async {
//                print("открытие приложухи по пушу1")
//            }
//        }
//    }
//
//    ///открытие пушей(раскоменти потом)
//
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//
//        print("открытие приложухи по пушу2")
//    }
//
//
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        print("Unable to register for remote notifications: \(error.localizedDescription)")
//    }
//
//    ///методы экстеншена
//
//    internal func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.alert])
//    }
////
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//
//        print("нажатие на кнопки пуша пуш")
//
//        completionHandler()
//    }
//}

