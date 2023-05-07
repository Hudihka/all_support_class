//
//  Models.swift
//  georgiaParser
//
//  Created by Худышка К on 07.05.2023.
//

import Foundation

struct EpicWithQwestion {
    
    let name: String
    let qwestions: [Qwestion]
    
}

struct Qwestion {
    let number: Int
    let title: String
    let linkImage: String?
    let answer: Answer
}

struct Answer {
    let rightOpinion: Int
    
    let fist: String
    let second: String
    let three: String?
    let four: String?
}
