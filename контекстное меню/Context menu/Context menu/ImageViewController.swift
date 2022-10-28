//
//  ImageViewController.swift
//  Context menu
//
//  Created by Hudihka on 20/10/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
	var image = UIImage()
	
	override func viewDidLoad() {
        super.viewDidLoad()

		self.imageView.image = image
    }
    
	static func route(image: UIImage) -> ImageViewController{
		
		let storuboard = UIStoryboard(name: "Main", bundle: nil)
		let VC = storuboard.instantiateViewController(identifier: "ImageViewController") as! ImageViewController
		VC.image = image
		
		return VC
	}


}
