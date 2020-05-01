//
//  TestVC.swift
//  infinitiScroll
//
//  Created by Hudihka on 01/05/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class TestVC: UIViewController {
	
	
	let shapeLayer = CAShapeLayer()
	
	override func viewDidLoad() {
        super.viewDidLoad()

		let minPi: Double = Double.pi * 0.075
		
		let minAngel = -0.5 * .pi + minPi
		let maxAngle = (3 * .pi / 2) - minPi
        
		
		
		let shapeLayer = CAShapeLayer()
		let centre = view.center
		let cirklePath = UIBezierPath(arcCenter: centre,
									  radius: 100,
									  startAngle: CGFloat(minAngel),
									  endAngle: CGFloat(maxAngle),
									  clockwise: true)
		shapeLayer.path = cirklePath.cgPath
		shapeLayer.strokeColor = UIColor.red.cgColor
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.lineWidth = 10
		shapeLayer.strokeEnd = 0
		shapeLayer.lineCap = .round
		
		view.layer.addSublayer(shapeLayer)
    }

	@IBAction func sliderAction(_ sender: UISlider) {
		
		shapeLayer.strokeEnd = CGFloat(sender.value)
	}
	
	@IBAction func tapedAction(_ sender: UIButton) {
		
		
	}
	
	
}
