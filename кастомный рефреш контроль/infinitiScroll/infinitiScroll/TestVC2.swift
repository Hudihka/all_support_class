//
//  TestVC2.swift
//  infinitiScroll
//
//  Created by Hudihka on 01/05/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class TestVC2: UIViewController {
	
	//	https://www.youtube.com/watch?v=IWujpBGqxfQ
	
	@IBOutlet weak var testview: UIView!
	let shapeLayerBig = CAShapeLayer()
	let shapeLayerSmall = CAShapeLayer()
	
	private let minPi: Double = Double.pi * 0.075
	

    override func viewDidLoad() {
        super.viewDidLoad()

		self.view.layer.addSublayer(shapeLayerBig)

		let path = UIBezierPath(arcCenter: self.view.center,
								radius: 100,
								startAngle: CGFloat(-0.5 * .pi + minPi),
								endAngle: CGFloat((3 * .pi / 2) - minPi),
								clockwise: true)
		
		shapeLayerBig.path = path.cgPath
		shapeLayerBig.lineWidth = 10
		shapeLayerBig.strokeColor = UIColor.red.cgColor
		shapeLayerBig.fillColor = UIColor.clear.cgColor
		shapeLayerBig.lineCap = .round
		
		shapeLayerBig.strokeEnd = 0
		
		
		self.view.layer.addSublayer(shapeLayerSmall)

		let path2 = UIBezierPath(arcCenter: self.view.center,
								radius: 50,
								startAngle: CGFloat((.pi / 2) - minPi),
								endAngle: CGFloat((.pi / 2) + minPi),
								clockwise: false)
		
		shapeLayerSmall.path = path2.cgPath
		shapeLayerSmall.lineWidth = 10
		shapeLayerSmall.strokeColor = UIColor.red.cgColor
		shapeLayerSmall.fillColor = UIColor.clear.cgColor
		shapeLayerSmall.lineCap = .round
		
		shapeLayerSmall.strokeEnd = 0
		
		

    }
	@IBAction func actionSlider(_ sender: UISlider) {
		shapeLayerBig.strokeEnd = CGFloat(sender.value)
		shapeLayerSmall.strokeEnd = CGFloat(sender.value)
		
		
		if sender.value == 1{
			addAnimateRotate()
		}
	}
	
	private func addAnimateRotate(){
		let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
		rotation.toValue = Double.pi * 2
		rotation.duration = 5 // or however long you want ...
		rotation.isCumulative = true
		rotation.repeatCount = Float.greatestFiniteMagnitude
		testview.layer.add(rotation, forKey: "rotationAnimation")
	}

	
	@IBAction func action(_ sender: UIButton) {
	}
	
}
