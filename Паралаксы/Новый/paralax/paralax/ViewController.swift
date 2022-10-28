//
//  ViewController.swift
//  paralax
//
//  Created by Hudihka on 05/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
	}

	@IBAction func present(_ sender: UIButton) {
		
		let VC = sender.tag == 0 ? DefaultController.route() : CustomController.route()
		VC.modalPresentationStyle = .fullScreen
		
		self.present(VC, animated: true, completion: nil)
	}
	
	
	
}

