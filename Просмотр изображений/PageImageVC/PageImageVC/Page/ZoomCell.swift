//
//  ZoomCell.swift
//  PageImageVC
//
//  Created by Hudihka on 03/10/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class ZoomCell: UICollectionViewCell {

	@IBOutlet private weak var spiner: UIActivityIndicatorView!
	@IBOutlet private weak var imageView: UIImageView!
	
	@IBOutlet private weak var topConstreint: NSLayoutConstraint!
	
	
	var image: UIImage? {
		didSet{
			if let image = image {
				self.imageView.image = image
				spiner.stopAnimating()
			}
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
