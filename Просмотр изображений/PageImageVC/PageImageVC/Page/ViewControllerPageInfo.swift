//
//  ViewControllerPageInfo.swift
//  PageImageVC
//
//  Created by Hudihka on 25/09/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class ViewControllerPageInfo: UIViewController {

	@IBOutlet private weak var imageView: UIImageView!
	@IBOutlet private weak var spiner: UIActivityIndicatorView!
	
	var image: UIImage?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		spiner.startAnimating()
		view.backgroundColor = .black
		
		
		if let image = image {
			imageView.image = image
			spiner.stopAnimating()
		}
		
	}
	
	static func route() -> ViewControllerPageInfo {
		
		let storuboard = UIStoryboard(name: "PageStoryboard", bundle: nil)
		let VC = storuboard.instantiateViewController(withIdentifier: "ViewControllerPageInfo") as! ViewControllerPageInfo

        return VC
    }
	

}
