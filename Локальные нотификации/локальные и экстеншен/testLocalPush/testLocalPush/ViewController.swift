//
//  ViewController.swift
//  testLocalPush
//
//  Created by Админ on 05.06.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func poehali(_ sender: Any) {
        
        
        
        
        
    }
    
    
    
    private func scheduleNotification(notifaicationType: String) {
        
        let content = UNMutableNotificationContent()
        let userActions = "User Actions"
        
        content.title = notifaicationType
        content.body = "Summer Time"
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userActions
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let identifire = "Local Notification"
        let request = UNNotificationRequest(identifier: identifire,
                                            content: content,
                                            trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        
    }
    


}

