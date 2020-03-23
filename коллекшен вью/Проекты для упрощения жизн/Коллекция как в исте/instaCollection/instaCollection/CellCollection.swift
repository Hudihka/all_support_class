//
//  CellCollection.swift
//  instaCollection
//
//  Created by Hudihka on 14/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class CellCollection: UICollectionViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    
    var name: String? {
        didSet{
            imageCell.image = nil
            if let name = name{
                self.imageCell.image = UIImage(named: name)
            }
        }
    }
    
}
