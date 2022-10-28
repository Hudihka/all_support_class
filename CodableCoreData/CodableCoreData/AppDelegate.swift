//
//  AppDelegate.swift
//  CodableCoreData
//
//  Created by Константин Ирошников on 17.10.2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var CDManager = CoreDataManager.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        CDManager.initialize()
		
		let users = CoreDataUtilities<User>.getAllObject()
		print("всего \(users)")

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func applicationDidEnterBackground(_ application: UIApplication){
        CDManager.saveContext()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CDManager.saveContext()
    }


}

extension NSObject {
    static func performOnce(selector: Selector, afterDelay delay: TimeInterval, with object: Any? = nil) {
        cancelPreviousPerformRequests(withTarget: self, selector: selector, object: nil)
        self.perform(selector, with: object, afterDelay: delay)
    }

    func performOnce(selector: Selector, afterDelay delay: TimeInterval, with object: Any? = nil) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: selector, object: nil)
        self.perform(selector, with: object, afterDelay: delay)
    }

    class var className: String {
        String(describing: self)
    }

    class func entityName() -> String {
        String(describing: self)
    }
}
