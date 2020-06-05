//
//  ViewController.swift
//  testLocalPush
//
//  Created by Админ on 05.06.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func poehali(_ sender: Any) {
        scheduleNotification()
    }
    
    
    
    private func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        
        content.title = "EXTENSION"
        content.body = "Summer Time"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "userActionsCategory" //ид категории
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let identifire = "Local Notification"
        let request = UNNotificationRequest(identifier: identifire,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        
    }
    
    
    ///просто локальные
    
    @IBAction func local(_ sender: Any) {
        
        let content = UNMutableNotificationContent()
        
        content.title = "TEST LOCAL"
        content.body = "Summer Time LOCAL"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let identifire = "Local Notification LOcal"
        let request = UNNotificationRequest(identifier: identifire,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        
    }
    
    
    


}

