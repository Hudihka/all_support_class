//
//  RecieptViewControllerModel.swift
//  FooDoo.ai
//
//  Created by Hudihka on 12/01/2022.
//  Copyright © 2022 ITMegastar. All rights reserved.
//

import Foundation

final class RecieptViewControllerModel: RecieptViewControllerProtocolIn,
                                        RecieptViewControllerProtocolOut {
    
    private let contentSingl = Content.shared
    private let contentEpics = Content.shared.epicks
    private var localQwestionAnswers: [EpicWithQwestion] = []
    private var number = 0

    var content: (URL?) -> Void = { _ in }

    func fetchData() {
//        guard let firstNumber = contentEpics.first?.arrayNumbers.first, let url = generateUrlWith(firstNumber) else {
//            return
//        }
        
        guard let url = generateUrlWith(403) else {
            return
        }
        
        self.number = 403
        
        content(url)
    }
    
    func next(html: Any?) {
        guard let html = html as? String else {
            fatalError()
        }
        
        print(Qwestion(html: html, number: number))
    }
}

private extension RecieptViewControllerModel {
    func generateUrlWith(_ number: Int) -> URL? {
        URL(string: "https://teoria.on.ge/tickets?ticket=\(number)")
    }
}
