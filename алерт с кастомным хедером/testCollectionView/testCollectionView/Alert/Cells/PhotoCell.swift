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
    
    var ind: IndexPath?{
        didSet{
            self.imageView.image = nil
            if let ind = ind {
                update(index: ind)
            }
        }
    }


    private func update(index: IndexPath){
        ManagerPhotos.shared.getImageOne(indexPath: index) {[weak self] (img) in
            self?.imageView.image = img
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.addRadius(number: 6)
    }

}
