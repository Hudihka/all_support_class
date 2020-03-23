//
//  ApplicationOpportunities.swift
//  GinzaGO
//
//  Created by Hudihka on 31/03/2019.
//  Copyright © 2019 Hudihka. All rights reserved.

import UserNotifications
import UIKit

class ApplicationOpportunities: NSObject {
    static var pushNotificStatus = false

    static func getNotificationActive() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                ApplicationOpportunities.pushNotificStatus = settings.authorizationStatus == .authorized
            }
        } else {
            ApplicationOpportunities.pushNotificStatus = UIApplication.shared.isRegisteredForRemoteNotifications
        }
    }

    static var versionAplication: String {
        guard let appVersion = Bundle.main.infoDictionary else {
            return "1.0"
        }

        let version = appVersion["CFBundleShortVersionString"] as? String
        return version ?? "1.0"
    }
}
