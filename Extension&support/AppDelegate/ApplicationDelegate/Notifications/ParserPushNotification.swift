//
//  ParserPushNotification.swift
//  GinzaGO
//
//  Created by Username on 26.08.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
//

import Foundation
import UIKit

class ParserPushNotification: NSObject {

    private var activeVC: UIViewController {
        return UIApplication.shared.workVC
    }

    func parserPush( _ userInfo: [AnyHashable: Any]) {

        //"{\"APPROVER_NAME\":\"\",\"ENTITY_ID\":4950845,\"APPROVEMENT_RESULT\":\"\",\"ENTITY_TYPE\":\"TASK\"}" 
        guard let string = userInfo["data"] as? String,
            let obj = string.components(separatedBy: ",").filter({$0.contains("ENTITY_ID")}).first, //\"ENTITY_ID\":4950845
            let taskID = Int32(obj.numbersInString) else {
                return
        }

        goDetailInfoVC(taskID)

    }

    // MARK: Open VC

    private func goDetailInfoVC(_ id: Int32) {
        openPushVC(id) {
            if let detailVC = self.activeVC as? DetailedInfoAppVC {
                detailVC.clearVC(id: id)
            } else {
                self.activeVC.openVCDetailInfo(id: id, taskString: "Заявка id \(id)")
            }
        }
    }


    private func openPushVC( _ id: Int32, completion: @escaping () -> Void) {

        if !activeVC.isModal {
            completion()
        } else {
            activeVC.dismiss(animated: true) {
                completion()
            }
        }
    }


}
