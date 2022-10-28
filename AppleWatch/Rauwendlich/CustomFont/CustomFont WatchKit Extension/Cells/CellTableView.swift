//
//  CellTableView.swift
//  CustomFont WatchKit Extension
//
//  Created by Константин Ирошников on 17.09.2022.
//

import Foundation
import WatchKit

final class CellTableView: NSObject {

    @IBOutlet var titleLabel: WKInterfaceLabel!

    var content: Content? {
        didSet {
            setup()
        }
    }

    private func setup() {
        guard let content = content else {
            return
        }

        let text = content.text

        titleLabel.setText(text)

        if let color = content.color {
            titleLabel.setTextColor(color)
            return
        }

        if let font = content.font {
            titleLabel.setFont(font, text: text)
            return
        }
    }
}

extension WKInterfaceLabel {
    func setFont(_ font: UIFont, text: String) {
        let attrStr = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: font])
        self.setAttributedText(attrStr)
    }
}
