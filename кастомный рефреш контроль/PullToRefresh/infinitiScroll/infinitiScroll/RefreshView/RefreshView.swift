//
//  RefreshView.swift
//  infinitiScroll
//
//  Created by Hudihka on 01/05/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class RefreshView: UIView {

	@IBOutlet var countentView: UIView!
	
	
	@IBOutlet weak var circleViewBig: CircleView!
	@IBOutlet weak var circleViewSmall: CircleView!
	
	var animateCirkles = false
	
	//если тру то вю будет всегда по центру
	private let circleViewInCentre = true
	@IBOutlet private weak var constreintUp: NSLayoutConstraint!
	@IBOutlet private weak var withBigView: NSLayoutConstraint!
	
	var block: () -> () = { }
	
	var offset: CGFloat? {
		didSet{
			if let offset = offset, offset <= -30{ //начнаем рисовать не сразу
				
				let absValue = abs(offset)
				let lenght = (absValue - 30) / 100
				lenghntCirkle(letnght: lenght)

				if circleViewInCentre {
					let position = (absValue - withBigView.constant) / 2
					constreintUp.constant = position
				}

			}
			
		}
	}
	
	override init (frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        settingsView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        settingsView()
    }


    func xibSetup() {
        countentView = loadViewFromNib("RefreshView")
        countentView.frame = bounds
        countentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(countentView)
    }


    private func settingsView(){
	
		circleViewBig.startValue = EnumAngels.zero.finishValue(from: false)
		circleViewBig.finishValue = EnumAngels.zero.finishValue(from: true)
		circleViewBig.clockwise = true
		
		circleViewSmall.startValue = EnumAngels.sixHours.finishValue(from: true)
		circleViewSmall.finishValue = EnumAngels.sixHours.finishValue(from: false)
		circleViewSmall.clockwise = false
		
    }
	
	private func lenghntCirkle(letnght: CGFloat){
		if animateCirkles, letnght > 0 {
			return
		}
		

		if letnght >= 1 {
			animateCirkles = true
			circleViewBig.infinitiRotate(clockRotate: true, duratiuon: 1, key: "key1")
			circleViewSmall.infinitiRotate(clockRotate: false, duratiuon: 0.5, key: "key2")
		} else {
			circleViewBig.value = letnght
			circleViewSmall.value = letnght
		}
	}
	
	func stopedAnimateRotate(){
		
		if animateCirkles {
			circleViewBig.layer.removeAnimation(forKey: "key1")
			circleViewSmall.layer.removeAnimation(forKey: "key2")
			
			
			UIView.animate(withDuration: 0.3, animations: {
				self.circleViewBig.value = 0
				self.circleViewSmall.value = 0
			}) { (compl) in
				if compl {
					self.animateCirkles = false
					self.block()
				}
			}
		}
	}


    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}


