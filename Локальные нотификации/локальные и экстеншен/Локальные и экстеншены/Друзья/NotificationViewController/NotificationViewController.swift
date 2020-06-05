//
//  NotificationViewController.swift
//  NotificationViewController
//
//  Created by Erica Millado on 5/1/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var friendsImage: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //5 - set the proportional vertical size of the notification.
        let size = view.bounds.size
        preferredContentSize = CGSize(width: size.width, height: size.height / 4.0)

    }
    
    //6 - Called when a notification arrives for your app.
    func didReceive(_ notification: UNNotification) {
        answerLabel.text = "How Well Do You Know Your Friends?"
    }
  
    //7 - Implement a method that will be called when the user taps on any of the notification actions.
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
    
          if response.actionIdentifier == "ross" {
            friendsImage.image = #imageLiteral(resourceName: "rossCorrect")
            answerLabel.text = "That's the correct answer!"
          } else if response.actionIdentifier == "chandler" {
            friendsImage.image = #imageLiteral(resourceName: "chandlerWrong")
            answerLabel.text = "Could you BE more wrong!?"
          } else {
            friendsImage.image = #imageLiteral(resourceName: "joeyWrong")
            answerLabel.text = "Try again... or go eat a sandwich."
          }
          //8 - Do not dismiss the notification interface. The content extension handles the selected action.
          completion(.doNotDismiss)
        
    }
  
  

}




