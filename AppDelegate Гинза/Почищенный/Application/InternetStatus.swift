//
//  InternetStatus.swift
//  GinzaGO
//
//  Created by Username on 26.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

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
                    print("есть соединение")
                }
            }
        }
        manager?.startListening()
    }

    func alertNoInternet() {
        let vc = UIApplication.shared.getWorkVC()
        if DowloadFileManager.shared.flagsActiveAlert {
            DowloadFileManager.shared.dismisAlert()
            vc.presentBlure(option: .noInternet)
        } else if let vcBlure = vc as? BlureViewController {
            vcBlure.newBanerAndDeleteBader(.noInternetAndActiveBuyingProcess)
        } else {
            vc.presentBlure(option: .noInternet)
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
