//
//  ColorController.swift
//  ColorPicker WatchKit Extension
//
//  Created by Константин Ирошников on 21.08.2022.
//  Copyright © 2022 Ray Wenderlich. All rights reserved.
//

import WatchKit

class ColorController: WKInterfaceController {
    @IBOutlet var bacgroundGroup: WKInterfaceGroup!
    @IBOutlet var label: WKInterfaceLabel!

    var activeColor = UIColor.white

    override func awake(withContext context: Any?) {
      super.awake(withContext: context)

        setTitle("пока")
        
      if let color = context as? UIColor {
        update(color: color)
      }
    }

    func update(color: UIColor) {
        activeColor = color
        bacgroundGroup.setBackgroundColor(color)
        label.setText("#" + color.hexString)
    }

    func updateSelectedColor() {
      ColorManager.defaultManager.selectedColor = activeColor
    }

    override func didAppear() {
      super.didAppear()
      updateSelectedColor()
    }

    @IBAction func onDarken() {
      update(color: activeColor.darkerColor())
      updateSelectedColor()
    }

    @IBAction func onLighten() {
      update(color: activeColor.lighterColor())
      updateSelectedColor()
    }
}
