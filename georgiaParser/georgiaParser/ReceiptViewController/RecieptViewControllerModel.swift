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
    private var localQwestion: [Qwestion] = []
    private var number = 0

    var content: (URL?) -> Void = { _ in }

    func fetchData() {
        guard
            let firstNumber = contentEpics.first?.arrayNumbers.first
        else {
            return
        }
        
        updateConent(firstNumber)
    }
    
    func next(html: Any?) {
        guard
            let html = html as? String,
            let qwestion = Qwestion(html: html, number: number)
        else {
            print(number)
            fatalError()
        }
        
        localQwestion.append(qwestion)
        
        if
            let firstEpic = contentEpics.first(where: { $0.arrayNumbers.contains(number) }),
            let indexEpic = contentEpics.firstIndex(where: { $0.russName == firstEpic.russName }),
            let lastNumber = firstEpic.arrayNumbers.last
        {
            if lastNumber == number {
                
                let newAnswers = EpicWithQwestion(name: firstEpic.russName, qwestions: localQwestion)
                localQwestionAnswers.append(newAnswers)
                localQwestion = []
                
                
                if let nextepic = contentEpics[safe: indexEpic + 1], let newFirst = nextepic.arrayNumbers.first {
                    // новый эпик
                    updateConent(newFirst)
                } else {
                    // закончились эпики
                    contentSingl.epicQwestions = localQwestionAnswers
                    print("-----------------------------------------------------------")
                    print("-----------------------------------------------------------")
                    print("-----------------------------------------------------------")
                    print(contentSingl.epicQwestions)
                    print("-----------------------------------------------------------")
                    print("-----------------------------------------------------------")
                    print("-----------------------------------------------------------")
                    
                    print("всего \(contentSingl.epicQwestions.count) темы")
                    
                    var summ = 0
                    for i in contentSingl.epicQwestions.map({ $0.qwestions.count }) {
                        summ += i
                    }
                    
                    print("всего \(summ) вопроса")
                    
                    print("-----------------------------------------------------------")
                    print("-----------------------------------------------------------")
                    print("-----------------------------------------------------------")
                }
            } else if
                let indexQwestion = firstEpic.arrayNumbers.firstIndex(where: { $0 == self.number }),
                let next = firstEpic.arrayNumbers[safe: indexQwestion + 1]
            {
                updateConent(next)
            }
        }
        
        
        
    }
}

private extension RecieptViewControllerModel {
    func generateUrlWith(_ number: Int) -> URL? {
        URL(string: "https://teoria.on.ge/tickets?ticket=\(number)")
    }
    
    func updateConent(_ index: Int) {
        guard
            let url = generateUrlWith(index)
        else {
            fatalError()
        }
        
        self.number = index
        
        content(url)
    }
}
