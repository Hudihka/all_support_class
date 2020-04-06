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
		
		
		
    }
	
	private func addGesture(){ // если тру то будет добавлен жест со свайпоп
        
        let oneTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected(_:)))
		transformView?.addGestureRecognizer(oneTap)
		

        let longPres = UILongPressGestureRecognizer(target: self,
													action: #selector(transformGesters))
		
		transformView?.addGestureRecognizer(longPres)
		longPres.minimumPressDuration = 0.0001
		longPres.delegate = self

		oneTap.require(toFail: longPres)

    }

	@objc private func tapDetected(_ sender: UITapGestureRecognizer) {
		
	}
	
	@objc private func transformGesters(_ sender: UITapGestureRecognizer) {
		
	}

}



extension CollectionViewCell: UIGestureRecognizerDelegate {
	
	
	
	
	
}
