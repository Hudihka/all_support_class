
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "ru.swiftbook.semaphores", attributes: .concurrent)  //семафор по сути говорит сколько одновременно потоков может выполняться

let semaphore = DispatchSemaphore(value: 2) // 0 - 1 - 0 - 1 - 0 - 1 - 2    //создаем семафор и говорим что на нем может сразу выполнятся 2 потоков
//semaphore.signal()     //если создать семафор с кол -вом сигналов 0 то необходимо сразу подать сигнал на выполнение
queue.async {
    semaphore.wait(timeout: .distantFuture) //семафор ждет пока не получит сигнал .signal()
    Thread.sleep(forTimeInterval: 4)        //поток уснул на 4 секунды
    print("Block 1")
    semaphore.signal()                      //говорит о том что следующий поток может начинать выполнение
}

queue.async {
    semaphore.wait(timeout: .distantFuture)
    Thread.sleep(forTimeInterval: 2)
    print("Block 2")
    semaphore.signal()
}

queue.async {
    semaphore.wait(timeout: .distantFuture)
    print("Block 3")
    semaphore.signal()
}

queue.async {
    semaphore.wait(timeout: .distantFuture)
    print("Block 4")
    semaphore.signal()
}















