//
//  UITableView.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 Hudihka. All rights reserved.
//


import UIKit

typealias TuplCellIndex = (isFirst: Bool, isLast: Bool)

extension UITableView {
    func isLastCell(index: IndexPath) -> Bool {
        let lastSectionIndex = self.numberOfSections - 1
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1

        return index == IndexPath(row: lastRowIndex, section: lastSectionIndex)
    }
    
    func isLastSection(index: Int) -> Bool {
        let lastSectionIndex = self.numberOfSections - 1
        return index == lastSectionIndex
    }
    
    func removeLastSeparators(){
        self.tableFooterView = UIView()
    }

    func addTableHeaderViewLine() {
        self.tableHeaderView = {
            let line = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1))
            line.backgroundColor = separator
            return line
        }()
    }

    func addTableFooterViewLine() {
        self.tableFooterView = {
            let line = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1))
            line.backgroundColor = separator
            return line
        }()
    }


    func baseSettingsTV(obj: UITableViewDelegate & UITableViewDataSource,
                        scrollEnabled: Bool = true,
                        separatorStyle: UITableViewCell.SeparatorStyle? = .none,
                        heghtCell: CGFloat?,
                        arrayNameCell: [String]?,
                        completion: (() -> Void)?){

            self.delegate = obj
            self.dataSource = obj
            self.backgroundColor = UIColor.clear
            self.isScrollEnabled = scrollEnabled

            if let separatorStyle = separatorStyle {
                self.separatorStyle = separatorStyle
            }

            if let heghtCell = heghtCell {
                self.estimatedRowHeight = heghtCell
            }

            arrayNameCell?.forEach({ (cellName) in
                self.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
            })

            completion?()

    }


    func reloadDataHeader(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.reloadData()
        }
    }

}

extension UITableViewCell {

    func selectColor(){
        let view = UIView()
//        view.backgroundColor = colorBacground //колор выделения
        self.selectedBackgroundView = view
    }

    func desingSeparator(isLast: Bool, offset: CGFloat = 18) {
        if !isLast{
            self.addSeparator(offset, isDown: true)
        }
    }

}
