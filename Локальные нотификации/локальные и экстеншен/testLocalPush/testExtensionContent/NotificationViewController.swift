//
//  NotificationViewController.swift
//  testExtensionContent
//
//  Created by Админ on 05.06.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var friendsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let size = view.bounds.size
        preferredContentSize = CGSize(width: size.width, height: size.height / 4)
        
    }
    
        func didReceive(_ notification: UNNotification) {
            print("------------------------------")
          answerLabel.text = "How Well Do You Know Your Friends?"
      }
    
      //7 - Implement a method that will be called when the user taps on any of the notification actions.
      func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        
        print("------------------------------")
      
            if response.actionIdentifier == "ross" {
              friendsImage.image = UIImage(named: "test1")
              answerLabel.text = "That's the correct answer!"
            } else if response.actionIdentifier == "chandler" {
              friendsImage.image = UIImage(named: "test2")
              answerLabel.text = "Could you BE more wrong!?"
            } else {
              friendsImage.image = UIImage(named: "test3")
              answerLabel.text = "Try again... or go eat a sandwich."
            }
            //8 - Do not dismiss the notification interface. The content extension handles the selected action.
            completion(.doNotDismiss)
          
      }

}
