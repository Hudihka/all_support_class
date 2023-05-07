//
//  Models.swift
//  georgiaParser
//
//  Created by Худышка К on 07.05.2023.
//

import Foundation

struct Epic: Hashable {
    let number: Int
    let russName: String
    let arrayNumbers: [Int]
}

struct EpicWithQwestion {
    
    let name: String
    let qwestions: [Qwestion]
    
}

struct Qwestion {
    let number: Int
    let title: String
    let linkImage: String?
    let answer: Answer
    
//    init?(html: String, number: Int) {
//        guard
//            let htmlAswers = html.between("<div class=\"item\">", "</article>"),
//            let title = htmlAswers.between("px;\">", "</span></p>"),
//            let answers = Answer(htmlAswers: htmlAswers)
//        else {
//            return nil
//        }
//
//        self.number = number
//        self.answer = answers
//        self.title = title
//        self.linkImage = htmlAswers.between("<img src=\"", "\" alt=\"\">")
//    }
}

struct Answer {
    let rightOpinion: Int
    
    let fist: String
    let second: String
    let three: String?
    let four: String?
    
//    init?(htmlAswers: String) {
//
//        let arrayHTML = htmlAswers.components(separatedBy: "<span class=\"text-wrap\" style=")
//        let opinion = arrayHTML.compactMap({ $0.between(";\">", "</span>") })
//
//        guard
//            let first = opinion[safe: 0],
//            let second = opinion[safe: 1]
//        else {
//            return nil
//        }
//
//        self.fist = first
//        self.second = second
//        self.three = opinion[safe: 2]
//        self.four = opinion[safe: 3]
//
//        var number = 1
//        let numbers = [4, 3, 2, 1]
//        for i in numbers {
//            if let _ = htmlAswers.between("</p><p class=\"t-answer t-answer-\(i)", "data-is-correct-list=\"true\">") {
//                number = i
//                break
//            }
//        }
//
//        self.rightOpinion = number - 1
//    }
}
