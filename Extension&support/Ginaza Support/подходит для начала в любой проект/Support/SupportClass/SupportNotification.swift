//
//  SupportNotification.swift
//  GinzaGO
//
//  Created by Username on 31.01.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import UIKit


enum NotificationName: String{

    case reloadBlureVC = "yyyyyy"
    case lllllBlureVC = "llllll"


    var nameNotific: NSNotification.Name {
        return NSNotification.Name(self.rawValue)
    }

}

class SupportNotification: NSObject {

    static func notific(_ name: NotificationName) {
        NotificationCenter.default.post(name: name.nameNotific, object: nil)
    }

    static func notific(_ name: NotificationName, userInfo: [String: Any]) {
        NotificationCenter.default.post(name: name.nameNotific, object: nil, userInfo: userInfo)
    }


}

/*

 NotificationCenter.default.addObserver(self,
 selector: #selector(appExitBacground(notfication:)),
 name: UIApplication.willEnterForegroundNotification,
 object: nil)

 NotificationCenter.default.addObserver(self,
 selector: #selector(rebootGoogleMap),
 name: .rebootGoogleMap,
 object: nil)


 @objc func rebootGoogleMap(notfication: Notification) {}

 deinit {
 NotificationCenter.default.removeObserver(self)
 }

 */
