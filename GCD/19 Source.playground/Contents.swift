
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// по сути это создание таймера который будет работать не только на основном потоке

let queue = DispatchQueue(label: "ru.swiftbook.sources", attributes: .concurrent)

let timer = DispatchSource.makeTimerSource(queue: queue) //создаем таймер и задаем для него очередь

timer.schedule(deadline: .now(), repeating: .seconds(2), leeway: .milliseconds(300))
               //когда начнет выполнять
                                //как часто
                                                        //своего рода задержка
timer.setEventHandler {     //что мы делаем когда срабатывает таймер
    print("Hello, World!")
}

timer.setCancelHandler {    //что мы делаем когда УНИЧТОЖАЕТСЯ таймер
    print("Timer is cancelled")
}

timer.resume()             //запуск таймера










