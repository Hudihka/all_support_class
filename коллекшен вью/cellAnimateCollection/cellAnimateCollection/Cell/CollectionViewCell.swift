//
//  CollectionViewCell.swift
//  cellAnimateCollection
//
//  Created by Hudihka on 06/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
	
	var transformView: TransformViewCollection?
	
	var name: String = "" {
		didSet{
			transformView?.desingContent(imageName: name)
		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        
		let rect = CGRect(x: 20, y: 10, width: wDdevice - 40, height: wDdevice)
		
		transformView = TransformViewCollection(frameCustom: rect)
		
		guard let transformView = transformView else {
			return
		}
		
		self.contentView.addSubview(transformView)
		
		transformView.addShadow()
		
		addGesture()
		
    }
	
	private func addGesture(){ // если тру то будет добавлен жест со свайпоп
        
//        let oneTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected(_:)))
//		transformView?.addGestureRecognizer(oneTap)
		
        let longPres = UILongPressGestureRecognizer(target: self,
													action: #selector(transformGesters))

		transformView?.addGestureRecognizer(longPres)
		longPres.minimumPressDuration = 0.0001
		longPres.allowableMovement = 0
//		longPres.delegate = self
		
//		let longPres = UIGestureRecognizer(target: self,
//										   action: #selector(transformGesters))
//
//		transformView?.addGestureRecognizer(longPres)
////		longPres.minimumPressDuration = 0.0001
//
////		longPres.cancelsTouchesInView = false
////		longPres.delaysTouchesBegan = false
//		longPres.delaysTouchesEnded = false
//
//
//
//		longPres.delegate = self
		

//		longPres.require(toFail: oneTap)
	

    }

	@objc private func tapDetected(_ sender: UITapGestureRecognizer) {
		
		print("-----")
		
//		guard let transformView = transformView else {
//			return
//		}
		
//        public static var calculationModeLinear: UIView.KeyframeAnimationOptions { get } // default
//
//        public static var calculationModeDiscrete: UIView.KeyframeAnimationOptions { get }
//
//        public static var calculationModePaced: UIView.KeyframeAnimationOptions { get }
//
//        public static var calculationModeCubic: UIView.KeyframeAnimationOptions { get }
//
//        public static var calculationModeCubicPaced: UIView.KeyframeAnimationOptions { get }
		
		
//		calculationModeLinear// ускоряется по ходу
//		calculationModeDiscrete// замедляется
		
//		UIView.animateKeyframes(withDuration: 0.2,
//								delay: 0,
//								options: [.calculationModePaced],
//								animations: {
//									transformView.transform = CGAffineTransform(scaleX: 0.92,
//																				y: 0.92)
//		},
//								completion: { (_) in
//
//		})
		
		
	}
	
	@objc private func transformGesters(_ sender: UILongPressGestureRecognizer) {
		
		print("00000")
		
//		guard let transformView = transformView else {
//			return
//		}
//
//		let size = transformView.frame.size
//
//		UIView.animateKeyframes(withDuration: 0.3,
//								delay: 0,
//								options: [.calculationModeDiscrete],
//								animations: {
//									transformView.transform = CGAffineTransform(scaleX: 0.9 * size.width,
//																				y: 0.9 * size.height)
//		},
//								completion: { (_) in
//
//		})
		
		
	}

}



extension CollectionViewCell: UIGestureRecognizerDelegate {
	
	
	
	
	
}
