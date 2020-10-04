//
//  ZoomCell.swift
//  PageImageVC
//
//  Created by Hudihka on 03/10/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class ZoomCell: UICollectionViewCell {
	
	var clerarNavigationBar: () -> () = { }

	@IBOutlet private weak var spiner: UIActivityIndicatorView!
	
	private var zoomView: ZoomView? = nil
	
	var image: UIImage? {
		didSet{
			if let image = image {
				spiner.stopAnimating()
				addZoomView(image)
			}
		}
	}
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
		self.contentView.backgroundColor = .clear
    }
	
	private func addZoomView(_ image: UIImage){
		if let zoomView = self.zoomView {
			zoomView.removeFromSuperview()
		}
		
		let size = CGSize(width: wDdevice, height: hDdevice)
		self.zoomView = ZoomView(frame: CGRect(origin: .zero, size: size))
		
		guard let zoomView = self.zoomView else {
			return
		}
		
		self.contentView.addSubview(zoomView)
		zoomView.set(image: image)
		
		zoomView.tapedClearNavigationBar = {
			self.clerarNavigationBar()
		}
		
//		let panGestures = UIPanGestureRecognizer(target: self, action: #selector(dragAndDrop))
//		zoomView.addGestureRecognizer(panGestures)
	}

}
