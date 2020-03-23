//
//  ParserPushNotification.swift
//  GinzaGO
//
//  Created by Username on 26.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

enum EnumTypePush: String, CaseIterable {
    case fridge = "NOTIFY_FRIDGE"
    case promo  = "NOTIFY_PROMO"
    case none  = "NONE"
}

class ParserPushNotification: NSObject {
    func parserPush( _ userInfo: [AnyHashable: Any]) {
        if let str = userInfo["url"] as? String?, let url = str {
            openVC(url: url)
            return
        }

        if let str = userInfo["click_action"] as? String, str == "NOTIFY_FRIDGE_STATE"{
            SupportNotification.notific(name: "rebootGoogleMap")
            return
        }

        if let ID = ExtensionJson.anyToIntAnyHashableJSON(userInfo, "target_id") {
            let value = parserType(userInfo)
            if value == .fridge {
                openVC(fridgeID: ID)
                return
            } else if value == .promo {
                openVC(stockID: ID)
                return
            }
        }

        return
    }

    private func parserType(_ userInfo: [AnyHashable: Any]) -> EnumTypePush {
        if let value = userInfo["click_action"] as? String {
            switch value {
            case EnumTypePush.fridge.rawValue:
                return .fridge

            case EnumTypePush.promo.rawValue:
                return .promo

            default:
                return .none
            }
        }
        return .none
    }

    private func openVC(url: String? = nil, fridgeID: Int? = nil, stockID: Int? = nil) {
        if let url = url {
            openCheckVC(url)
            return
        } else if let fridID = fridgeID {
            openPushVC(fridID) { (ID) in
                SupportFridge.fridgeID = Int32(ID)
                SupportFridge.openFridgeWidtID()
            }
            return
        } else if let stockID = stockID {
            openPushVC(stockID) { (_) in
                self.openStock(Int32(stockID))
            }
            return
        }
    }

    private func openStock(_ id: Int32) {
        guard let VCBlure = BlureViewController.route() else {
            return
        }

        let selfVC = UIApplication.shared.getWorkVC()

        selfVC.present(VCBlure, animated: false, completion: nil)

        GGApi.actions { (array, _) in
            if let array = array, let newStock = array.filter({ $0.id == id }).first {
                if let infoVC = StockInformationVC.route(food: newStock) {
                    selfVC.buttonback("Акции", vc: infoVC)
                }
                CoreDataManager.shared.save()
                VCBlure.dismisVC()
            } else {
                VCBlure.newBanerAndDeleteBader(.banerError)
            }
        }
    }

    // MARK: Open VC

    private func openCheckVC( _ strUrl: String) {
        if let url = URL(string: strUrl) {
            let selfVC: UIViewController = UIApplication.shared.getWorkVC()
            let time = thisIsBlureVC(selfVC) ? 0.1 : 0
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                CheckViewController.presentCheckVC(selfVC, url)
            }
        }
    }

    private func openPushVC( _ id: Int, completion: @escaping (Int) -> Void) {
        let selfVC = UIApplication.shared.getWorkVC()

        if !selfVC.isModal {
            completion(id)
        } else {
            selfVC.dismiss(animated: true) {
                completion(id)
            }
        }
    }

    private func thisIsBlureVC(_ VC: UIViewController) -> Bool {
        if VC is BlureViewController {
            return true
        }
        return false
    }
}
