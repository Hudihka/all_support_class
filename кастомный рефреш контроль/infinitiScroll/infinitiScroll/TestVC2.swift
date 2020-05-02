//
//  TestVC2.swift
//  infinitiScroll
//
//  Created by Hudihka on 01/05/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class TestVC2: UIViewController {
	
	@IBOutlet weak var viewTest: UIView!
	
	var imageStrat = UIImageView()
	var labelFinish = UILabel()
	var isFlip = false
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		let rect = CGRect(origin: .zero, size: viewTest.frame.size)

		imageStrat = UIImageView(frame: rect)
		imageStrat.image = UIImage(named: "testImg1")
		
		labelFinish = UILabel(frame: rect)
		labelFinish.text = "TEXT"
		labelFinish.textColor = .white
		labelFinish.backgroundColor = .red
		labelFinish.textAlignment = .center
		labelFinish.font = UIFont.systemFont(ofSize: 15, weight: .bold)
		
		viewTest.addSubview(labelFinish)
		viewTest.addSubview(imageStrat)
	}
	
	
	@IBAction func actionCancel(_ sender: UIButton) {
	
		isFlip = !isFlip
		let startView = isFlip ? imageStrat : labelFinish
		let finishView = isFlip ? labelFinish : imageStrat
		let option: UIView.AnimationOptions = isFlip ? .transitionFlipFromTop : .transitionFlipFromBottom
		
		UIView.transition(from: startView,
						  to: finishView,
						  duration: 0.5,
						  options: [.curveEaseOut, option]) { (_) in
			print("")
		}
		
	}
	
	
	
	

}
