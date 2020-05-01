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
	
	@IBOutlet private weak var upConstreint: NSLayoutConstraint!
	
	@IBOutlet weak var wBigView: NSLayoutConstraint!
	@IBOutlet weak var upConstreintBigWiev: NSLayoutConstraint!
	
	@IBOutlet weak var wSmallView: NSLayoutConstraint!
	
	
	@IBOutlet weak var circleViewBig: CircleView!
	@IBOutlet weak var circleViewSmall: CircleView!
	
	var animateCirkles = false
	var blockUpConstreint = false
	
	var block: () -> () = { }
	
	private let maxOffset: CGFloat = -100
	
	var offset: CGFloat? {
		didSet{
			
			guard let offset = offset, offset < 0 else {
				return
			}
			
			upConstreint.constant = offset
			
			let absValue = abs(offset)
			
			/*констреин того что бы вьью была по центру*/
			let centerPosition = (absValue - RefreshConstant.hBigView)/2
			upConstreintBigWiev.constant = centerPosition
			
			/*рисуем круги*/
			let offsetPath = absValue - RefreshConstant.startVisibleOffsetBig
			lenghntCirkle(offset: offsetPath)
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
		
		
		upConstreintBigWiev.constant = -1 * RefreshConstant.startVisibleOffsetBig
		

		circleViewBig.startValue = EnumAngels.zero.finishValue(from: false)
		circleViewBig.finishValue = EnumAngels.zero.finishValue(from: true)
		circleViewBig.clockwise = true
		
		
		circleViewSmall.startValue = EnumAngels.sixHours.finishValue(from: true)
		circleViewSmall.finishValue = EnumAngels.sixHours.finishValue(from: false)
		circleViewSmall.clockwise = false
		
    }
	
	private func lenghntCirkle(offset: CGFloat){
		if animateCirkles, offset > 0 {
			return
		}
		
		let letnght = offset / 100
		
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
			
//			upConstreint.constant = 0
			
			UIView.animate(withDuration: 0.2,
						   delay: 0.1,
						   options: [],
						   animations: {
							self.upConstreint.constant = 0
			}, completion: nil)
			
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


