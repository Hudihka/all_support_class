//
//  UITableView.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//


import UIKit

extension UITableView {
    func isLastCell(index: IndexPath) -> Bool {
        let lastSectionIndex = self.numberOfSections - 1
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1

        return index == IndexPath(row: lastRowIndex, section: lastSectionIndex)
    }

}
