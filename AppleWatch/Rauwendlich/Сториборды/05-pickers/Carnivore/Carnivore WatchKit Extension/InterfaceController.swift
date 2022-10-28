/**
* Copyright (c) 2017 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
* distribute, sublicense, create a derivative work, and/or sell copies of the
* Software in any work that is designed, intended, or marketed for pedagogical or
* instructional purposes related to programming, coding, application development,
* or information technology.  Permission for such use, copying, modification,
* merger, publication, distribution, sublicensing, creation of derivative works,
* or sale is expressly withheld.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    @IBOutlet weak var timer: WKInterfaceTimer!
    @IBOutlet weak var timerButton: WKInterfaceButton!

    @IBOutlet weak var weightLabel: WKInterfaceLabel!
    @IBOutlet weak var temperatureLabel: WKInterfaceLabel!
    @IBOutlet weak var weightPicker: WKInterfacePicker!
    @IBOutlet weak var temperaturePicker: WKInterfacePicker!

    private var oz = 16
    private var cookTemp = MeatTemperature.medium
    private var timerRunning = false
    private var usingMetric = false

  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
      timerButton.setTitle("Start Timer")
      
      settingsWeightPicker()
      settingsTemperaturePick()

      updateConfiguratin()
  }

    @IBAction func onTapedTimer() {
        if timerRunning {
            timer.stop()
            timerButton.setTitle("Start Timer")
        } else { // 2
            let time = cookTemp.cookTimeForOunces(oz)
            timer.setDate(Date(timeIntervalSinceNow: time))
            timer.start()
            timerButton.setTitle("Stop Timer")
        }

        timerRunning = !timerRunning
        scroll(to: timer, at: .top, animated: true)
    }

    @IBAction func onWeightChanged(_ value: Int) {
        oz = value + 1
        updateConfiguratin()
    }

    @IBAction func onTemperatureChange(_ value: Int) {
        guard let temp = MeatTemperature(rawValue: value) else {
            return
        }
        cookTemp = temp
        temperatureLabel.setText(temp.stringValue)
    }

    private func updateConfiguratin() {
        var weight = oz
        var unit = "oz"
        if usingMetric {
          // 2
          let grams = Double(oz) * 28.3495
          weight = Int(grams)
          unit = "gm"
      }

//        outletSwitch.setTitle(unit)
        weightLabel.setText("Weight: \(weight) \(unit)")
//        cookLabel.setText(cookTemp.stringValue)
    }

    private func settingsWeightPicker() {

        var weightItems: [WKPickerItem] = []
        for i in 1...32 {

            let item = WKPickerItem()
          item.title = String(i)
          weightItems.append(item)
        }

        weightPicker.setItems(weightItems)
        weightPicker.setSelectedItemIndex(oz - 1)
    }

    private func settingsTemperaturePick() {
        var tempItems: [WKPickerItem] = []

        for i in 1...4 {
          let item = WKPickerItem()
          item.contentImage = WKImage(imageName: "temp-\(i)")
          tempItems.append(item)
        }

        temperaturePicker.setItems(tempItems)
        onTemperatureChange(0)
    }

    override func interfaceOffsetDidScrollToTop() {
        print("User scrolled to top")
    }
    override func interfaceDidScrollToTop() {
        print("User went to top by tapping status bar")
    }
    override func interfaceOffsetDidScrollToBottom() {
        print("User scrolled to bottom")
    }
}
