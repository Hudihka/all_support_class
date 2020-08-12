//
//  MyCustomCell.swift
//  testCollectionView
//
//  Created by Hudihka on 06/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    
    private let manager = ManagerPhotos.shared
    
    var ind: IndexPath?{
        didSet{
            self.imageView.image = nil
            self.spiner.stopAnimating()
            if let ind = ind {
                update(index: ind)
            }
        }
    }


    private func update(index: IndexPath){
        manager.getImageOne(indexPath: index) {[weak self] (img) in
            self?.imageView.image = img
        }
        
        if let indexBig = manager.indexBigPhoto, index == indexBig{
            self.spiner.startAnimating()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.addRadius(number: 6)
    }

}
