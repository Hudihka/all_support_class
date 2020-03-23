//
//  CollectionCellPhotos.swift
//  Photi Lirary
//
//  Created by Hudihka on 19/07/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class CollectionCellPhotos: UICollectionViewCell {

    @IBOutlet weak var imageCell: UIImageView!

    var index: IndexPath? {
        didSet {
            update()
        }
    }

    func update() {
        imageCell.image = UIImage(named: "grumpy-cat") ?? UIImage()
        if let ind = index {
            ManagerLibsUserPhoto.shared.getImage(index: ind) { (image) in
                if let img = image {
                    self.imageCell.image = img
                }
            }
        }
    }

}
