//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "ru.swiftbook", attributes: .concurrent) //создаем очередь под названием "ru.swiftbook", очередь паралельная (.concurrent)
let group = DispatchGroup() //создаем группу

queue.async(group: group) {  // добавляем группу на нашу очередь
    for i in 0...10 {
        if i == 10 {
            print(i)
        }
    }
}

queue.async(group: group) {
    for i in 0...20 {
        if i == 20 {
            print(i)
        }
    }
}

group.notify(queue: .main) { // код вызывается когда все выполнено в группе
    print("Все закончено в группе: group")
}

let secondGroup = DispatchGroup()
secondGroup.enter() // говорит о том что начали выполнение кода в группе

queue.async(group: group) {
    for i in 0...30 {
        if i == 30 {
            print(i)
        }
    }
}
secondGroup.leave() // говорит о там что закончили выполнение кода в группе

let result = secondGroup.wait(timeout: .now() + 1) //выполнен или нет код в группе (success значит выполнен)
print(result)

secondGroup.notify(queue: .main) {
    print("Все закончено в группе: secondGroup")
}

print("Этот принт должен быть выше чем последний")

secondGroup.wait() //ждем выполнение кода в группе, программа не будет дальше выполняться









