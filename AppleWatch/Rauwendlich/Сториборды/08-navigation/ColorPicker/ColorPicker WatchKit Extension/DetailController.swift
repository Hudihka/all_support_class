//
//  DetailController.swift
//  ColorPicker WatchKit Extension
//
//  Created by Константин Ирошников on 22.08.2022.
//  Copyright © 2022 Ray Wenderlich. All rights reserved.
//

import UIKit
import WatchKit

class DetailController: WKInterfaceController {
    @IBOutlet var hexLabel: WKInterfaceLabel!
    @IBOutlet var rgbLabel: WKInterfaceLabel!
    @IBOutlet var hslLabel: WKInterfaceLabel!

    override func willActivate() {
      super.willActivate()

      let color = ColorManager.defaultManager.selectedColor
      hexLabel.setText("#" + color.hexString)
      rgbLabel.setText(color.rgbString)
      hslLabel.setText(color.hslString)
    }

}
