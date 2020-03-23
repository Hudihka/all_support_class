//
//  SupportNotification.swift
//  GinzaGO
//
//  Created by Username on 31.01.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
//

import UIKit


enum EnumNotification: String{

    case reloadPageVC           = "reloadPageVC"
    case rejectOrApproveTask    = "rejectOrApproveTask"  //принять отклонить заявку

    case newFiltersSelected     = "newFiltersSelected"   //выбрали новые фильтры и перезагружаем таблицу
    case playNewFilters         = "playNewFilters"       //загрузка данных с учетом фиильтров
    case playInternetStatus     = "playInternetStatus"   //запрос на бэк прии смене интернет статуса


//    case reloadBlure            = "reloadBlure"          //подгрузка фильтров с бэка закончена, показываем шторку


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

//    func reloadBlure(_ userInfo: EnumBlureVC?) {
//
//        var userInfoNotific: [String : Any]? = nil
//
//        if let value = userInfo {
//            userInfoNotific = ["NewBlureValue" : value]
//        }
//
//        NotificationCenter.default.post(name: self.nameNotific, object: nil, userInfo: userInfoNotific)
//    }



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
