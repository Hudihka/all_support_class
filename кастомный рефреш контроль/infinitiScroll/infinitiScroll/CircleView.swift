//
//  CircleView.swift
//  infinitiScroll
//
//  Created by Hudihka on 01/05/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import UIKit

class CircleView: UIView {
	
	var startValue: Double?{
		didSet{
			addCircle()
		}
	}
	
	var finishValue: Double?{
		didSet{
			addCircle()
		}
	}
	
	var clockwise: Bool?{
		didSet{
			addCircle()
		}
	}
	
	let shapeLayer = CAShapeLayer()
	
	var value: CGFloat = 0{
		didSet{
			shapeLayer.strokeEnd = value
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	
	private func addCircle() {
		
//		self.backgroundColor = UIColor.clear
		guard let startValue = startValue,
			let finishValue = finishValue,
			let clockwise = clockwise else {
			return
		}
		
		self.layer.addSublayer(shapeLayer)
		let radius = min(self.frame.width, self.frame.height)/2

		let path = UIBezierPath(arcCenter: CGPoint(x: radius, y: radius),
								radius: radius,
								startAngle: CGFloat(startValue),
								endAngle: CGFloat(finishValue),
								clockwise: clockwise)
		
		shapeLayer.path = path.cgPath
		shapeLayer.lineWidth = 1
		shapeLayer.strokeColor = UIColor.red.cgColor
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.lineCap = .round
		
		shapeLayer.strokeEnd = 0
	}
	
	
}
