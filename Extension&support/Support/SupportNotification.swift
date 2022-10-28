//
//  SupportNotification.swift
//  GinzaGO
//
//  Created by Username on 31.01.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import UIKit


enum EnumNotification: String{

    case reloadPageVC           = "reloadPageVC"

    var nameNotific: NSNotification.Name {
        return NSNotification.Name(self.rawValue)
    }

    func subscribeNotific(observer: Any, selector: Selector){
        NotificationCenter.default.addObserver(observer,
                                               selector: selector,
                                               name: self.nameNotific,
                                               object: nil)
    }

    func notific() {
        NotificationCenter.default.post(name: self.nameNotific, object: nil)
    }


    func notific(userInfo: [String: Any]) {
        NotificationCenter.default.post(name: self.nameNotific, object: nil, userInfo: userInfo)
    }


    //только для обновления блюра




}


extension Notification {

    var rejectTask: Bool? {

        guard let userInfo = self.userInfo, let tag = userInfo["tag"] as? Int, tag != 0 else {
            return nil
        }

        return tag == 1
    }
    
    var message: String?{
        return self.userInfo?["message"] as? String
    }

    var keyBakend: String?{
        return self.userInfo?["keyBakend"] as? String
    }

    var countTask: Int?{
        return self.userInfo?["countTask"] as? Int
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
