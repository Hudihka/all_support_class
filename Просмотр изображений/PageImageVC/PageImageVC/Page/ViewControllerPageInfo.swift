//
//  ViewControllerPageInfo.swift
//  PageImageVC
//
//  Created by Hudihka on 25/09/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class ViewControllerPageInfo: UIViewController {

	@IBOutlet private weak var spiner: UIActivityIndicatorView!
	
	var image: UIImage?
	
	private var isHideStatusBar = false
	
	override var prefersStatusBarHidden: Bool {
		 return isHideStatusBar
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		spiner.startAnimating()
		view.backgroundColor = .clear
		
		if let image = image {
			let zoomView = ZoomView(frame: CGRect(origin: .zero, size: self.view.frame.size))
			self.view.addSubview(zoomView)
			zoomView.set(image: image)
			spiner.stopAnimating()
			
			zoomView.tapedClearNavigationBar = {
				self.clerarNavigationBar()
			}
			
		}
		
//		self.navigationController?.navigationBar.isTranslucent = false
		
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
		
		self.isHideStatusBar = true
		self.setNeedsStatusBarAppearanceUpdate()
		
		UIView.animate(withDuration: 0.2,
					   delay: 0,
					   options: [.curveEaseIn],
					   animations: {
						NB.navigationBar.frame = finalFrame
		},
					   completion: nil)
		
	}
	

}
