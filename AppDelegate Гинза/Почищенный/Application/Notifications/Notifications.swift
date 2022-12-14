//
//  Notifications.swift
//  GinzaGO
//
//  Created by Username on 27.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation
import Firebase
import UserNotifications
import Fabric
import Crashlytics
import GooglePlaces
import GoogleMaps

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    func registerPods() {
        Fabric.with([Crashlytics.self])

        GMSServices.provideAPIKey("AIzaSyBdufEq9FvTPnhPWCfGyjn-4mL_wxQU6hQ")
        GMSPlacesClient.provideAPIKey("AIzaSyBdufEq9FvTPnhPWCfGyjn-4mL_wxQU6hQ")
    }

    func initNotification(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self

        registerForPushes(application)
        getApplicationInstanceID()
        application.registerForRemoteNotifications()

        self.openPushAplication(launchOptions)
    }

    private func registerForPushes(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self

            let arraySettings: UNAuthorizationOptions = [.alert, .sound, .badge]

            UNUserNotificationCenter.current().requestAuthorization(options: arraySettings) { (granted, _) in
                print("Permission granted: \(granted)")

                UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                    print("Notification settings: \(settings)")
                    //2//4
                    DispatchQueue.main.async {
                        guard settings.authorizationStatus == .authorized else {
                            return
                        }
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
    }

    private func openPushAplication(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
            DispatchQueue.main.async {
                self.parserPush.parserPush(notification) //открытие приложухи по пушу
            }
        }
    }

    private func getApplicationInstanceID() {
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
        }
    }

    ///открытие пушей

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if self.flagPlayOpenAplication {
            self.parserPush.parserPush(userInfo)
        }

        self.flagPlayOpenAplication = true
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        self.token = fcmToken

        if DefaultsUtils.currentAccount() != nil {
            GGApi.reloadUserFairbaseToken(fcmToken)
        }
    }

    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }

    // MARK: - NewTocken

    func deleteTocken() {
        let instance = InstanceID.instanceID()
        instance.deleteID { (error) in
            print(error.debugDescription)
        }

        instance.instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else {
                print("Remote instance ID token: \(String(describing: result?.token))")
            }
        }
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
}

@available(iOS 10, *)

extension AppDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent")//это невидимые пуши
        completionHandler([.alert, .sound])
        SupportNotification.notific(name: "rebootGoogleMap")
    }
}
