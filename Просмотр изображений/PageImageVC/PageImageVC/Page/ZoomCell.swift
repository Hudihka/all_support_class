//
//  ZoomCell.swift
//  PageImageVC
//
//  Created by Hudihka on 03/10/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class ZoomCell: UICollectionViewCell {
	
	var translationBlock: (CGFloat) -> () = { _ in }
	var closeBlock: (Bool) -> () = { _ in }
	
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
		
		let panGestures = UIPanGestureRecognizer(target: self, action: #selector(dragAndDrop))
		zoomView.addGestureRecognizer(panGestures)
	}
	
	@objc private func dragAndDrop(sender: UIPanGestureRecognizer) {
		
		guard let zoomView = self.zoomView else {
			return
		}
		
		let position = sender.translation(in: self.contentView)
		let point = CGPoint(x: 0, y: position.y)
		let size = CGSize(width: wDdevice, height: hDdevice)
		zoomView.frame = CGRect(origin: point, size: size)
		
		let translation = 150 - abs(position.y)
		
		
		if translation < 0 {
			translationBlock(0)
		} else {
			translationBlock(translation/150)
		}
		
		
		if sender.state == .ended{
			if translation < 0{
				//анимация закрытия экрана
				self.closeBlock(true)
			} else {
				self.closeBlock(false)
				UIView.animate(withDuration: timeInterval) {
					self.zoomView?.frame = CGRect(origin: .zero, size: size)
				}
			}
		}
	}
}
