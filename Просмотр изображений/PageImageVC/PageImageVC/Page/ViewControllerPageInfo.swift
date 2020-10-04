//
//  ViewControllerPageInfo.swift
//  PageImageVC
//
//  Created by Hudihka on 25/09/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

/*

class ViewControllerPageInfo: UIViewController {
	
	var translationBlock: (CGFloat) -> () = { _ in }
	var closeBlock: (Bool) -> () = { _ in }

	@IBOutlet private weak var spiner: UIActivityIndicatorView!
	
	var image: UIImage?
	var zoomView: ZoomView? = nil
	
	private var isHideStatusBar = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		spiner.startAnimating()
		view.backgroundColor = .clear
		
		if let image = image {
			self.zoomView = ZoomView(frame: CGRect(origin: .zero, size: self.view.frame.size))
			
			guard let zoomView = self.zoomView else {
				return
			}
			self.view.addSubview(zoomView)
			zoomView.set(image: image)
			spiner.stopAnimating()
			
			zoomView.tapedClearNavigationBar = {
				self.clerarNavigationBar()
			}
			
			let panGestures = UIPanGestureRecognizer(target: self, action: #selector(dragAndDrop))
			zoomView.addGestureRecognizer(panGestures)
			
		}
		
	}
	
	static func route() -> ViewControllerPageInfo {
		
		let storuboard = UIStoryboard(name: "PageStoryboard", bundle: nil)
		let VC = storuboard.instantiateViewController(withIdentifier: "ViewControllerPageInfo") as! ViewControllerPageInfo

        return VC
    }
	
	
	private func clerarNavigationBar() {
		
		guard let NB = self.navigationController else {return}
		
		let isOriginalFrame = rectNavigationBar(true) == NB.navigationBar.frame
		
		let finalFrame = rectNavigationBar(!isOriginalFrame)
		
		UIApplication.shared.keyWindow?.windowLevel = isOriginalFrame ? .statusBar : .normal
		
		UIView.animate(withDuration: timeInterval) {
			NB.navigationBar.frame = finalFrame
		}
		
	}
	
    @objc func dragAndDrop(sender: UIPanGestureRecognizer) {
		
		guard let zoomView = self.zoomView else {
			return
		}
		
		let position = sender.translation(in: self.view)
		let point = CGPoint(x: 0, y: position.y)
		zoomView.frame = CGRect(origin: point, size: self.view.frame.size)
		
		let translation = 100 - abs(position.y)
		
		
		if translation < 0 {
			translationBlock(0)
		} else {
			translationBlock(translation)
		}
		
		
		if sender.state == .ended{
			if translation < 0{
				//анимация закрытия экрана
				self.closeBlock(true)
			} else {
				self.closeBlock(false)
				UIView.animate(withDuration: timeInterval) {
					self.zoomView?.frame = CGRect(origin: .zero, size: self.view.frame.size)
				}
			}
		}
		
    }
	

}

*/
