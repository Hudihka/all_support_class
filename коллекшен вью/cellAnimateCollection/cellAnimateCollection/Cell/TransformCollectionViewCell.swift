//
//  TransformCollectionViewCell.swift
//  cellAnimateCollection
//
//  Created by Hudihka on 05/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class TransformCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var imageView: UIImageView!
	var name: String? {
		didSet{
			if let name = name {
				desingCell(name: name)
			}
		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	private func desingCell(name: String){
		
		imageView.image = UIImage(named: name)
		
	}

}
