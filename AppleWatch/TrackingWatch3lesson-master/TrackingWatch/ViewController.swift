//
//  ViewController.swift
//  TrackingWatch
//
//  Created by Алексей Пархоменко on 24.02.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stepsLabel: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    
    lazy var notificationCenter: NotificationCenter = {
        return NotificationCenter.default
    }()
    
    var notificationObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationObserver = notificationCenter.addObserver(forName: NSNotification.Name("activityNotification"), object: nil, queue: nil, using: { (notification) in
            self.updateLabels()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateLabels()
    }
    
    private func updateLabels() {
        DispatchQueue.main.async {
            self.stepsLabel.text = "Steps " + String(ActivityOffice.steps)
            self.distance.text = "Distance " + String(ActivityOffice.distance)
        }
    }
    
    deinit {
        if let observer = notificationObserver {
            notificationCenter.removeObserver(observer)
        }
    }


}

