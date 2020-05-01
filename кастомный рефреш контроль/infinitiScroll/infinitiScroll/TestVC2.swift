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
	@IBOutlet weak var slider: UISlider!
	
	var cirkleView: CircleView?
	var cirkleView2: CircleView?
	
	private var animateCirkles = false
	
    override func viewDidLoad() {
        super.viewDidLoad()

				
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
		
		lenghntCirkle(letnght: CGFloat(sender.value))
		
	}
	
	
	@IBAction func actionCancel(_ sender: UIButton) {
		if animateCirkles {
			stopedAnimateRotate()
		}
	}
	
	
	
	func lenghntCirkle(letnght: CGFloat){
		if animateCirkles {
			return
		}
		
		
		self.cirkleView?.value = letnght
		self.cirkleView2?.value = letnght
		
		if letnght == 1 {
			animateCirkles = true
			cirkleView?.infinitiRotate(clockRotate: true, duratiuon: 1, key: "key1")
			cirkleView2?.infinitiRotate(clockRotate: false, duratiuon: 1, key: "key2")
			slider.setValue(0, animated: true)
		}
	}
	
	func stopedAnimateRotate(){
		cirkleView?.layer.removeAnimation(forKey: "key1")
		cirkleView2?.layer.removeAnimation(forKey: "key2")
		
		cirkleView?.zeroingCGPath()
		cirkleView2?.zeroingCGPath()
		
		animateCirkles = false
	}
	

}
