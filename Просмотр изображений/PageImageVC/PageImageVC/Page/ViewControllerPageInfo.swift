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
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		spiner.startAnimating()
		view.backgroundColor = .clear
		
		if let image = image {
			let zoomView = ZoomView(frame: CGRect(origin: .zero, size: self.view.frame.size))
			self.view.addSubview(zoomView)
			zoomView.set(image: image)
			spiner.stopAnimating()
		}
		
	}
	
	static func route() -> ViewControllerPageInfo {
		
		let storuboard = UIStoryboard(name: "PageStoryboard", bundle: nil)
		let VC = storuboard.instantiateViewController(withIdentifier: "ViewControllerPageInfo") as! ViewControllerPageInfo

        return VC
    }
	

}
