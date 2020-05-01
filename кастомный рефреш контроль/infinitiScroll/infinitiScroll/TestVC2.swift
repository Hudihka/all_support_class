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
	
	@IBOutlet weak var testView2: UIView!
	@IBOutlet weak var testview: UIView!
	
	let shapeLayerBig = CAShapeLayer()
	let shapeLayerSmall = CAShapeLayer()
	
	var cirkleView: CircleView?
	var cirkleView2: CircleView?
	
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
		
		
		cirkleView = CircleView(frame: CGRect(x: 50, y: 100, width: 60, height: 60))
		cirkleView?.startValue = EnumAngels.zero.finishValue(from: false)
		cirkleView?.finishValue = EnumAngels.zero.finishValue(from: true)
		cirkleView?.clockwise = true
		self.view.addSubview(cirkleView!)
		
		
		cirkleView2 = CircleView(frame: CGRect(x: 65, y: 115, width: 30, height: 30))
		cirkleView2?.startValue = EnumAngels.sixHours.finishValue(from: true)
		cirkleView2?.finishValue = EnumAngels.sixHours.finishValue(from: false)
		cirkleView2?.clockwise = false
		self.view.addSubview(cirkleView2!)
		
		

    }
	@IBAction func actionSlider(_ sender: UISlider) {
		
		self.cirkleView?.value = CGFloat(sender.value)
		self.cirkleView2?.value = CGFloat(sender.value)
		
		if sender.value == 1 {
			cirkleView?.infinitiRotate(clockRotate: true, duratiuon: 1, key: "key1")
			cirkleView2?.infinitiRotate(clockRotate: false, duratiuon: 1, key: "key2")
		}
		
	}
	
	
}
