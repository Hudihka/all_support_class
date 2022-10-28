//
//  InterfaceController.swift
//  Hello Apple Watch WatchKit WatchKit Extension
//
//  Created by Константин Ирошников on 16.08.2022.
//  Copyright © 2022 Razeware. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var button: WKInterfaceButton!


    override func awake(withContext context: Any?) {
        reloadButton()
    }
    
    override func willActivate() {

    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

    @IBAction func tapedButton() {
        reloadButton()
    }

    private func reloadButton() {
        button.setBackgroundImageNamed("test")
        let structData = EmojiData()
        button.setTitle(structData.randomString)
    }
}
