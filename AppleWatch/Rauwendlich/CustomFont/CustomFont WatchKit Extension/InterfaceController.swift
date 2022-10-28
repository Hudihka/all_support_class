//
//  InterfaceController.swift
//  CustomFont WatchKit Extension
//
//  Created by Константин Ирошников on 14.09.2022.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var labelContent: WKInterfaceLabel!
    @IBOutlet weak var tableView: WKInterfaceTable!

    override func awake(withContext context: Any?) {
        settingsTableView()
    }
    
    private func settingsTableView() {
        let items = Colors.content

        // Configure the table object and get the row controllers.
        tableView.setNumberOfRows(items.count, withRowType: "CellTableView")

        for (index, item) in items.enumerated() {
            guard
                let cell = tableView.rowController(at: index) as? CellTableView
            else {
                continue
            }

            cell.content = item
        }
    }

    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let item = Colors.content[rowIndex]

        if let color = item.color {
            labelContent.setTextColor(color)
            return
        }

        if let font = item.font {
            labelContent.setFont(font, text: item.text)
            return
        }
    }
}
