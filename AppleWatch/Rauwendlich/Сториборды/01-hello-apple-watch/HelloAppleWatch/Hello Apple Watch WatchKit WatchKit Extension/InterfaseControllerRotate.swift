//
//  InterfaseControllerRotate.swift
//  Hello Apple Watch WatchKit WatchKit Extension
//
//  Created by Константин Ирошников on 20.08.2022.
//  Copyright © 2022 Razeware. All rights reserved.
//

import UIKit
import WatchKit

class InterfaseControllerRotate: WKInterfaceController {

    override func awake(withContext context: Any?) {

    }

    override func willActivate() {
        // поворот экрана
        WKExtension.shared().isAutorotating = true
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        WKExtension.shared().isAutorotating = false
    }
}
