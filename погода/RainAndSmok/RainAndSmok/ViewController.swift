//
//  ViewController.swift
//  RainAndSmok
//
//  Created by Hudihka on 06/06/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var rainView: RainView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func rainSwitch(_ sender: UISwitch) {
        settingsView(.rain, value: sender)
    }

    @IBAction func smokeSwitch(_ sender: UISwitch) {
        settingsView(.smok, value: sender)
    }

    @IBAction func rainValue(_ sender: UISlider) {
        rainView.settingsRain(slider: sender)
    }

    func settingsView(_ meteo: Meteo, value: UISwitch){
        if value.isOn{
            rainView.addMeteo(meteo)
        }else{
            rainView.deleteMeteo(meteo)
        }
    }
    
}

