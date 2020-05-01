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
	
	private var animateCirkles = false
	
	var block: () -> () = { }
	
	private let maxOffset: CGFloat = -100
	var offset: CGFloat? {
		didSet{
			if let offset = offset, offset < 0{
				let lenght = offset / maxOffset
				lenghntCirkle(letnght: lenght)
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
		if animateCirkles {
			return
		}
		
		
		if letnght >= 1 {
			animateCirkles = true
			circleViewBig.infinitiRotate(clockRotate: true, duratiuon: 1, key: "key1")
			circleViewSmall.infinitiRotate(clockRotate: false, duratiuon: 1, key: "key2")
		} else {
			circleViewBig.value = letnght
			circleViewSmall.value = letnght
		}
	}
	
	func stopedAnimateRotate(){
		
		if animateCirkles {
			circleViewBig.layer.removeAnimation(forKey: "key1")
			circleViewSmall.layer.removeAnimation(forKey: "key2")
			
			
			UIView.animate(withDuration: 3, animations: {
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


