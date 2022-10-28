//
//  NotificationController.swift
//  PawsomeWatch Extension
//
//  Created by Константин Ирошников on 25.08.2022.
//  Copyright © 2022 Razeware LLC. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications


class NotificationController: WKUserNotificationInterfaceController {

  @IBOutlet var label: WKInterfaceLabel!
  @IBOutlet var image: WKInterfaceImage!

    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

  /*
   Во-первых, вы переопределяете, который watchOS вызывается,
   когда он получает удаленное уведомление или во время тестирования, когда файл APNS
   выбрано. watchOS вызывает метод перед отображением интерфейса уведомлений,
   что позволяет настроить интерфейс.
   */

    override func didReceive(
      _ notification: UNNotification,
      withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Swift.Void
    ) {

      let notificationBody = notification.request.content.body
//      label.setText(notificationBody)
      label.setText("notificationBody")

      if let imageAttachment = notification.request.content.attachments.first {
        let imageURL = imageAttachment.url
        let imageData = try! Data(contentsOf: imageURL)
        let newImage = UIImage(data: imageData)
        image.setImage(newImage)
      } else {
        let catImageName = String(format: "cat%02d", arguments: [Int.randomInt(1, max: 20)])
        image.setImageNamed(catImageName)
      }

      completionHandler(.custom)
    }
}
