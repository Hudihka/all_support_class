//
//  MyCustomCell.swift
//  testCollectionView
//
//  Created by Hudihka on 06/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class MyCustomCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var name: String?{
        didSet{
            imageView.image = nil
            if let name = name{
               imageView.image = UIImage(named: name)
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = true
        layer.cornerRadius = 4
    }

}
