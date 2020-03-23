//
//  CustomTableViewCell.swift
//  tableView
//
//  Created by Hudihka on 12/10/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UITextView!

//    @IBOutlet weak var detailsConstreint: NSLayoutConstraint!

    var textStruct: RandomText? {
        didSet{
            updateText()
        }
    }


    private func updateText(){
        guard let textStruct = textStruct else {
            return
        }

        self.titleLabel.text = textStruct.tittle
        self.subTitleLabel.text = textStruct.subTittle

//        if textStruct.subTittle.count < 40 {
//            detailsConstreint.priority = UILayoutPriority(rawValue: 250)
//        } else {
//            detailsConstreint.priority = UILayoutPriority(rawValue: 999)
//        }


    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
