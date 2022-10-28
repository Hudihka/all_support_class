//
//  СustomTableViewCell.swift
//  tableView
//
//  Created by Hudihka on 09/10/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class СustomTableViewCell: BFPaperTableViewCell {

    @IBOutlet weak var labelCell: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()



        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
