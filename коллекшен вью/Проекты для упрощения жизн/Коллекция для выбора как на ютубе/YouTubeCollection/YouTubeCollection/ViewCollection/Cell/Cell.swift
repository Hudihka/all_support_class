//
//  Cell.swift
//  YouTubeCollection
//
//  Created by Hudihka on 14/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {

    @IBOutlet weak var viewSelect: UIView!
    @IBOutlet weak var labelText: UILabel!
    
    var model: (String, Bool)? {
        didSet{
            settings()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSelect.layer.cornerRadius = 20
        viewSelect.layer.masksToBounds = true
    }
    
    
    private func settings(){
        guard let model = model else {
            return
        }
        
        self.labelText.text = model.0
        self.viewSelect.backgroundColor = model.1 ? UIColor.red : UIColor.yellow
    }

}
