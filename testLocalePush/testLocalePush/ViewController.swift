//
//  ViewController.swift
//  testLocalePush
//
//  Created by Админ on 20.05.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func action(_ sender: Any) {
        
        print("нажали")
        
        let date = "\(Date())"
        
        let centre = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        content.title = date
        content.body = "--------------"
        content.sound = .default
        
        
        let identif = "\(date) reminder"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15 * 60, repeats: false)
        let request = UNNotificationRequest(identifier: identif,
                                            content: content,
                                            trigger: trigger)
        
        centre.add(request) { (error) in
            if error != nil{
                print("Error = \(error?.localizedDescription)")
            }
        }
    }
    
}

