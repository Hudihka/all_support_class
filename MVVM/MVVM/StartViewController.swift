//
//  ViewController.swift
//  MVVM
//
//  Created by Hudihka on 02/05/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var modelView = StartViewPresenter() {
		didSet{
			labelSlider.text = modelView.sliderText
			labelSniper.text = modelView.steperText
			labelSwitch.text = modelView.switchText
		}
	}
	
	@IBOutlet weak var labelSlider: UILabel!
	@IBOutlet weak var labelSniper: UILabel!
	@IBOutlet weak var labelSwitch: UILabel!
	
	@IBOutlet weak var slider: UISlider!
	@IBOutlet weak var steper: UIStepper!
	@IBOutlet weak var `switch`: UISwitch!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	
	@IBAction func sliderAction(_ sender: UISlider) {
		modelView.sliderValue(value: sender.value)
	}
	
	@IBAction func steperAction(_ sender: UIStepper) {
		modelView.steperValue(value: sender.value)
	}
	
	@IBAction func switchAction(_ sender: UISwitch) {
		modelView.switchValue(value: sender.isOn)
	}
	
	
	
}

