//
//  AppDelegate.swift
//  TrackingWatch
//
//  Created by Алексей Пархоменко on 24.02.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit
import CoreMotion
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWatchConnectivity()
        let motionManager = CMMotionActivityManager()
        let activityQueue = OperationQueue()
        motionManager.startActivityUpdates(to: activityQueue) { (_) in
            motionManager.stopActivityUpdates()
        }
        return true
    }
    
    func setupWatchConnectivity() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
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


}

extension AppDelegate: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            fatalError("Can't activate session with error: \(error.localizedDescription)")
        }
        print("WC Session activated with state: \(activationState.rawValue)")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print(#function)
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print(#function)
        WCSession.default.activate()
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let steps = applicationContext["steps"] as? Int, let distance = applicationContext["distance"] as? Double {
            ActivityOffice.steps = steps
            ActivityOffice.distance = distance
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "activityNotification"), object: nil)
            }
        }
    }
    
}

