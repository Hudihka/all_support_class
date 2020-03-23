//
//  UITableView.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

extension UITableView {
    func isLastCell(index: IndexPath) -> Bool {
        let lastSectionIndex = self.numberOfSections - 1
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1

        return index == IndexPath(row: lastRowIndex, section: lastSectionIndex)
    }

    /* в результате чего высота вьюхи хедера меняется  относительно ширины */

    func heigtHedersTableView(addInfo: CGFloat = 0) {
        guard let heder = self.tableHeaderView else {
            return
        }

        //        let height: CGFloat = type == .menu ? 68 : 64

        let startHeight = SupportClass.Dimensions.wDdevice * CGFloat(0.696) //125:87

        heder.frame = CGRect(origin: heder.frame.origin,
                             size: CGSize(width: SupportClass.Dimensions.wDdevice,
                                          height: startHeight + addInfo))
    }
}
