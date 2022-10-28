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
    
    @IBOutlet var labelDuration: UILabel!
    
    private let manager = ManagerPhotos.shared
    
    var ind: IndexPath?{
        didSet{
            self.imageView.image = nil
            self.spiner.stopAnimating()
            self.labelDuration.text = nil
            if let ind = ind {
                update(index: ind)
            }
        }
    }

    private func update(index: IndexPath){
        manager.getImageOne(indexPath: index) {[weak self] (img, duration)  in
            self?.imageView.image = img
            if let text = duration {
                self?.labelDuration.text = text
            }
        }
        
        if let indexBig = manager.indexBigContent, index == indexBig{
            self.spiner.startAnimating()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

