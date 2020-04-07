//
//  TwoViewController.swift
//  cellAnimateCollection
//
//  Created by Hudihka on 05/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
	var uiImage: UIImage?
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

		imageView.image = uiImage
    }
    
	@IBAction func dismis(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
	
	static func route(imageName: String) -> TwoViewController{
		
		let storubord = UIStoryboard(name: "Main", bundle: nil)
		
		let VC = storubord.instantiateViewController(withIdentifier: "TwoViewController") as! TwoViewController
		
		VC.uiImage = UIImage(named: imageName)
		
		return VC
		
	}

}
