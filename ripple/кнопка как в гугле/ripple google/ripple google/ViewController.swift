//
//  ViewController.swift
//  ripple google
//
//  Created by Hudihka on 09/10/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: ZFRippleButton!
    override func viewDidLoad() {
        super.viewDidLoad()


        button.trackTouchLocation = true
        button.rippleColor = UIColor.red //это цвет круга чо пойдетт
        button.rippleBackgroundColor = button.backgroundColor ?? UIColor.red //это цвет каким станет после нажатия
        button.shadowRippleRadius = 0
        button.ripplePercent = 1.3

//        button.shadowRippleEnable = f
    }


}

