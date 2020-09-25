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
	
	var image: UIImage? = nil {
		didSet{
			if let image = image {
				imageView.image = image
				spiner.stopAnimating()
			}
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		spiner.startAnimating()

    }
	
	
	

}
