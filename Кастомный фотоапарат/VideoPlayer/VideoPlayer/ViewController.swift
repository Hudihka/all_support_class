//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Админ on 19.08.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapedGalerey(_ sender: Any) {
        
        tapedGaleruPhoto {
            let VC = GaleryVC.route()
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
}

