//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class SafeArray<Element> {
    private var array = [Element]()
    private let queue = DispatchQueue(label: "DispatchBarrier", attributes: .concurrent)//создаем очередь под названием "DispatchBarrier", очередь паралельная (.concurrent)
    
    public func append(element: Element) {
        queue.async(flags: .barrier) { /*выполняя задачу на очереди мы ставим барьер, благодаря этому на потоке
                                        не будет выполняться ни каких задач пока задача не будет выполнена*/
            self.array.append(element)
        }
    }
    
    public var elements: [Element] {
        var result = [Element]()
        queue.sync { /*здесь мы получаем результат, обязательно выходим синхронно что бы закрыть поток для дальнейших действий*/
            result = self.array
        }
        
        return result
    }
}



var safeArray = SafeArray<Int>()
DispatchQueue.concurrentPerform(iterations: 20) { (index) in
    safeArray.append(element: index)
}
print("safeArray: \(safeArray.elements)")

/*в результате print("safeArray: \(safeArray.elements)") получим все 20 элементов*/


var array = [Int]()
DispatchQueue.concurrentPerform(iterations: 20) { (index) in
    array.append(index)
}
print("array: \(array)")
