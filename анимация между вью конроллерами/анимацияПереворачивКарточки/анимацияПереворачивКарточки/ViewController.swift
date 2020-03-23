//
//  ViewController.swift
//  анимацияПереворачивКарточки
//
//  Created by Hudihka on 18/08/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func goButton(_ sender: Any) {
        if let VC = UIStoryboard(name: "TwoStoryboard", bundle: nil).instantiateInitialViewController(){
            self.transition(VC: VC)
        }
    }
    
}

