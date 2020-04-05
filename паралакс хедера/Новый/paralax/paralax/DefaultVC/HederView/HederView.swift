//
//  HederView.swift
//  doubleParalax
//
//  Created by Hudihka on 18/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import Foundation
import UIKit

class HederView: UIView{
    
    @IBOutlet weak var conteinerView: UIView!

    @IBOutlet private weak var upConstreint: NSLayoutConstraint!
    
    @IBOutlet weak var imageContent: UIImageView!
	
	var SCView: UIScrollView? = nil
	
	convenience init(heightHeader: CGFloat, image: UIImage?, superView: UIScrollView) {
		
		let rect = CGRect(origin: .zero,
						  size: CGSize(width: superView.frame.width,
									   height: heightHeader))
		
		self.init(frameCustom: rect)
		
		self.imageContent.image = image
		self.SCView = superView
		
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
        conteinerView = loadViewFromNib("HederView")
        conteinerView.frame = bounds
        conteinerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(conteinerView)
    }

    private func settingsView() {
		imageContent.contentMode = .scaleAspectFill
		conteinerView.clipsToBounds = false
    }
    
    
    private func paralax(value: CGFloat) {
		
		
//        let delta: CGFloat = scrollView.contentOffset.y
//
//        addSettings(deltaNegative: delta < 0)
//        if delta < 0 {
//            swipeDownParalax(delta: delta)
//        } else if delta > 0{
//            swipeUpParalax(delta: delta / 2)
//        } else { //== 0
//
//        }
        
    }
	
	//MARK - KVC
	
	override open func observeValue(forKeyPath keyPath: String?,
									of object: Any?, change: [NSKeyValueChangeKey : Any]?,
									context: UnsafeMutableRawPointer?) {
		
        if keyPath == #keyPath(UIScrollView.contentOffset), let scroll = self.SCView {
			
			let offset = scroll.contentOffset.y
			
			if offset < 0 {
				self.upConstreint.constant = offset
			} else {
				self.upConstreint.constant = 0
			}
			
        }
    }
    


    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}


extension UIView {
	@objc func loadViewFromNib(_ name: String) -> UIView { //добавление вью созданной в ксиб файле
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: name, bundle: bundle)
		if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
			return view
		} else {
			return UIView()
		}
	}
}
