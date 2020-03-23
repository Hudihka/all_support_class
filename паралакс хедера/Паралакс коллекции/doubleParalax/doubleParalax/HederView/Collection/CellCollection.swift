//
//  CellCollection.swift
//  doubleParalax
//
//  Created by Hudihka on 19/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class CellCollection: UICollectionViewCell {
    
    private let placeholder = UIImage(named: "плейсхолдер")
    
    var newImage: UIImage? {
        didSet{
            imageView?.image = newImage ?? placeholder
        }
    }
    
    var imageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.red
        
        imageView = UIImageView(frame: self.frame)
        imageView?.contentMode = .scaleAspectFill
        imageView?.image = placeholder
        
        if let imageView = imageView {
            self.addSubview(imageView)
        }
        
    }
    
}
