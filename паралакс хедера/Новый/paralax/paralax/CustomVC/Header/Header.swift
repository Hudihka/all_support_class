//
//  HederView.swift
//  doubleParalax
//
//  Created by Hudihka on 18/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import Foundation
import UIKit

class Header: UIView{
    
    @IBOutlet weak var conteinerView: UIView!

    @IBOutlet private weak var upConstreint: NSLayoutConstraint!
    
    @IBOutlet weak var imageContent: UIImageView!
	
	var SCView: UIScrollView? = nil
	
	private let heightShadow: CGFloat = 40
	@IBOutlet weak var heghtShadow: NSLayoutConstraint!
	@IBOutlet weak var positionShadow: NSLayoutConstraint!
	@IBOutlet weak var imageShadow: UIImageView!
	
	
	convenience init(heightHeader: CGFloat, image: UIImage?, superView: UIScrollView) {
		
		let rect = CGRect(origin: .zero,
						  size: CGSize(width: superView.frame.width,
									   height: heightHeader))
		
		self.init(frameCustom: rect)
		
		self.imageContent.image = image
		self.SCView = superView
		self.desingShadow()
		
		SCView?.addObserver(self,
							forKeyPath: #keyPath(UIScrollView.contentOffset),
							options: [.new, .old],
							context: nil)
	}
	
    
    init(frameCustom: CGRect) {
        super.init(frame: frameCustom)
        xibSetup()
        settingsView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        settingsView()
    }
    
    private func xibSetup() {
        conteinerView = loadViewFromNib("Header")
        conteinerView.frame = bounds
        conteinerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(conteinerView)
    }

    private func settingsView() {
		imageContent.contentMode = .scaleAspectFill
		conteinerView.clipsToBounds = false
    }
    
	
	private func desingShadow(){
		
		imageShadow.image = #imageLiteral(resourceName: "shadow")
		heghtShadow.constant = heightShadow
		positionShadow.constant = self.frame.height - heightShadow
	}
	
	//MARK - KVC
	
	override open func observeValue(forKeyPath keyPath: String?,
									of object: Any?, change: [NSKeyValueChangeKey : Any]?,
									context: UnsafeMutableRawPointer?) {
		
        if keyPath == #keyPath(UIScrollView.contentOffset), let scroll = self.SCView {
			
			let offset = scroll.contentOffset.y
			
			if offset < 0 {
				self.upConstreint.constant = offset
			} else if offset == 0 {
				self.upConstreint.constant = 0
			} else if offset > 0 {
				self.upConstreint.constant = offset / 2
			}
			
        }
    }
    


    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}


