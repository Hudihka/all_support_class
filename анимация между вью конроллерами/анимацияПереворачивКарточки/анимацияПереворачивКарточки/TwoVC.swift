//
//  TwoVC.swift
//  анимацияПереворачивКарточки
//
//  Created by Hudihka on 18/08/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class TwoVC: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        if let VC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController(){
            self.transition(VC: VC)
        }
    }
    
}

