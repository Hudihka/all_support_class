//
//  ApplicationOpportunities.swift
//  GinzaGO
//
//  Created by Hudihka on 31/03/2019.
//  Copyright © 2019 Hudihka. All rights reserved.

import UserNotifications
import UIKit

class ApplicationOpportunities: NSObject {
    
	static func activePush(compl:@escaping(Bool) -> Void){
		if #available(iOS 10.0, *) {
            
            DispatchQueue.global(qos: .userInteractive).sync{
                UNUserNotificationCenter.current().getNotificationSettings {(settings) in
                    DispatchQueue.main.async {
						compl(settings.authorizationStatus == .authorized)
					}
                }
            }
            
        } else {
			compl(UIApplication.shared.isRegisteredForRemoteNotifications)
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
