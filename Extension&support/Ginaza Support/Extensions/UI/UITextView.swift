//
//  UITextView.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

public extension UITextView {
    /// количество линий в текстВью
    public var numberOfLines: Int {
        guard compare(beginningOfDocument, to: endOfDocument).same == false else {
            return 0
        }

        let direction: UITextDirection = UITextDirection(rawValue: UITextStorageDirection.forward.rawValue)
        var lineBeginning = beginningOfDocument
        var lines = 0
        while true {
            lines += 1
            guard let lineEnd = tokenizer.position(from: lineBeginning, toBoundary: .line, inDirection: direction) else {
                fatalError()
            }
            guard compare(lineEnd, to: endOfDocument).same == false else {
                break
            }
            guard let newLineBeginning = tokenizer.position(from: lineEnd, toBoundary: .character, inDirection: direction) else {
                fatalError()
            }
            guard compare(newLineBeginning, to: endOfDocument).same == false else {
                return lines + 1
            }
            lineBeginning = newLineBeginning
        }
        return lines
    }
}
