//
//  UITableView.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func isLastCell(index: IndexPath) -> Bool {
        let lastSectionIndex = self.numberOfSections - 1
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1

        return index == IndexPath(row: lastRowIndex, section: lastSectionIndex)
    }

    /* в результате чего высота вьюхи хедера меняется  относительно ширины на koef
     если хотим квадратную то передай 1*/

    func hedersTableView(koef: CGFloat, image: UIImage?) {
        if let _ = self.tableHeaderView {
            return
        }
        

        let startHeight = wDdevice * koef

        let frame = CGRect(origin: CGPoint.zero,
                             size: CGSize(width: wDdevice,
                                          height: startHeight))
        
        let heder = HederView(frame: frame)
        heder.backgroundColor = UIColor.red
        self.tableHeaderView = heder
        
        if let image = image {
            heder.imageContent.image = image
        }
        
    }
}
