//
//  InternetStatus.swift
//  GinzaGO
//
//  Created by Username on 26.08.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
//

import Foundation
import UIKit

class InternetStatus {
    static let sharedInstance = InternetStatus()

    private init() {}

    let manager = NetworkReachabilityManager(host: "www.apple.com")

    var isConnectedInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }

    var wasReachable = false
    private var firstConnection = false //при запуске приложения показывает что есть/нет соединение, а нам это не нужно

    func startNetwork() {
        manager?.listener = { status in
            switch status {
            case .notReachable:
                print("нет соединение")
                self.wasReachable = false
                self.presentInternet(disconect: true)
//                self.firstConnection = true

            case .unknown :
                print("не известно")

            case .reachable(.ethernetOrWiFi):
                fallthrough

            case .reachable(.wwan):
                if !self.wasReachable {
                    self.wasReachable = true

                    if self.firstConnection {
                        self.presentInternet(disconect: false)
                        print("есть соединение")
                    }
//                    self.firstConnection = true
                }
            }
        }
        manager?.startListening()

        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.firstConnection = true
        }
    }

    func alertNoInternet() {
        //TODO
        //показ алерта
    }


    func presentInternet(disconect: Bool) {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.2) {
            if disconect, !InternetStatus.sharedInstance.isConnectedInternet {
                self.viewInternet()
                EnumNotification.playInternetStatus.notific()
            } else if !disconect, InternetStatus.sharedInstance.isConnectedInternet{
                self.viewInternet()
                EnumNotification.playInternetStatus.notific()
            }
        }
    }

    private func viewInternet(){
        UIApplication.shared.workVC.viewInternetStatus()
    }


}
