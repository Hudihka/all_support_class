//
//  ManagerCounter.swift
//  combineTest
//
//  Created by Константин Ирошников on 11.06.2022.
//

import Foundation
import Combine

//https://www.swiftbysundell.com/articles/published-properties-in-swift/
// первый способ

final class ManagerCounter {
    private init() {}

    static let shared = ManagerCounter()

    @Published private(set) var counter = 0

//    var publisher: AnyPublisher<Int, Never> {
//        // Здесь мы "стираем" информацию о типе
//        // нашего субъекта. Мы лишь сообщаем нашему
//        // внешнему коду, что это read-only publisher:
//        subject.eraseToAnyPublisher()
//    }
//
//    // Храня наш субъект в приватном свойстве, мы можем
//    // лишь передавать новые значения в него из самого класса:
//    private let subject = PassthroughSubject<Int, Never>()
//
//    private var counter = 0 {
//        didSet{
//            subject.send(counter)
//        }
//    }

//    static let shared = ManagerCounter()

    func addCounter() {
        counter += 1
    }
}


/* второй способ
final class ManagerCounter {
    private init() {}

    static let shared = ManagerCounter()

    /*
     PassthroughSubjectиспользуется для представления событий.
     Используйте его для таких событий, как нажатие кнопки.

     CurrentValueSubjectиспользуется для обозначения состояния.
     Используйте его для хранения любого значения, скажем,
     состояния переключателя как выключенного и включенного.
     */

    var publisher: AnyPublisher<Int, Never> {
        // Здесь мы "стираем" информацию о типе
        // нашего субъекта. Мы лишь сообщаем нашему
        // внешнему коду, что это read-only publisher:
        subject.eraseToAnyPublisher()
    }

    // Храня наш субъект в приватном свойстве, мы можем
    // лишь передавать новые значения в него из самого класса:
    private let subject = PassthroughSubject<Int, Never>()

    private var counter = 0 {
        didSet{
            subject.send(counter)
        }
    }

//    static let shared = ManagerCounter()

    func addCounter() {
        counter += 1
    }
}
*/
