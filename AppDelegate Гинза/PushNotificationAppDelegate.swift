//
//  PushNotificationAppDelegate.swift
//  
//
//  Created by Username on 18.06.2019.
//


import Foundation
import Firebase
import UserNotifications

func appDelegateShared() -> AppDelegate {
    return UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"

    var token: String?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        ///////notification
        FirebaseApp.configure()
        Messaging.messaging().delegate = self

        self.registerForPushes(application)

        //get application instance ID
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
        }

        application.registerForRemoteNotifications()

        let networkStatus = InternetStatus.sharedInstance //интернет соединение
        networkStatus.startNetwork()
        networkStatus.presentAlertNoInternet()

        if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
            DispatchQueue.main.async {
                self.openCheckVC(notification)
            }
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        ApplicationOpportunities.getNotificationActive()//мы переопределяем может или нет наше приложение пользоваться нотификациями
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    // MARK: - PushNotification

    func registerForPushes(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self

            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, _) in
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

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        SupportNotification.notific(name: "appExitBacground")
        openCheckVC(userInfo)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        self.token = fcmToken

        let dataDict: [String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
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

    func logAuht() {  //выход из аккаунта
        self.deleteTocken()
    }
}

extension AppDelegate {   //функции нужны для открытия url в пуше
    func parserPush( _ userInfo: [AnyHashable: Any]) -> String? {
        print(userInfo)
        if let str = userInfo["url"] as? String?, let url = str {
            return url
        }

        return nil
    }

    func openCheckVC( _ userInfo: [AnyHashable: Any]) {
        if let selfVC: UIViewController = SupportClass.selfVC,
            let strUrl = parserPush(userInfo),
            let url = URL(string: strUrl) {
            let time = thisIsBlureVC(selfVC) ? 0.1 : 0
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                CheckViewController.presentCheckVC(selfVC, url)
            }
        }
    }

    func thisIsBlureVC(_ VC: UIViewController) -> Bool {
        if VC is BlureViewController {
            return true
        }
        return false
    }
}

@available(iOS 10, *)

extension AppDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent")
        completionHandler([.alert, .sound])
    }
}

class InternetStatus {
    static let sharedInstance = InternetStatus()

    private init() {}

    let manager = NetworkReachabilityManager(host: "www.apple.com")

    var isConnectedInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }

    var wasReachable = false

    func startNetwork() {
        manager?.listener = { status in
            switch status {
            case .notReachable:
                print("нет соединение")
                self.wasReachable = false
                self.presentAlertNoInternet()

            case .unknown :
                print("не известно")

            case .reachable(.ethernetOrWiFi):
                fallthrough

            case .reachable(.wwan):
                if !self.wasReachable {
                    self.wasReachable = true
                    SupportNotification.notific(name: "startInternetConnection")
                    print("есть соединение")
                }
            }
        }
        manager?.startListening()
    }

    func alertNoInternet() {
        if let vc = UIApplication.shared.keyWindow?.visibleViewController {
            if let vcBlure = vc as? BlureViewController {
                vcBlure.newBanerAndDeleteBader(.noInternetAndActiveBuyingProcess)
            } else {
                vc.presentBlure(option: .noInternet)
            }
        }
    }

    func presentAlertNoInternet() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.2) {
            if !InternetStatus.sharedInstance.isConnectedInternet {
                self.alertNoInternet()
            }
        }
    }
}
