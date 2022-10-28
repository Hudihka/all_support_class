
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
/*по сути блоки это клоужеры, разница в том что мы можем отменить их выполнение или же откладывать*/

let workItem = DispatchWorkItem(qos: .utility, flags: .detached) { //создаем блок
                                             //flags как выполняется блок в нутри очереди (есть в том числе и барьер),
                                             //detached значит что он опускает qos и принимает qos очереди в которой будет выполняться
    print("Performing workitem")
}

//workItem.perform() //запускаем выполнение блока

let queue = DispatchQueue(label: "ru.swiftbook", qos: .utility, attributes: .concurrent, autoreleaseFrequency: .workItem, target: DispatchQueue.global(qos: .userInitiated)) //создаем очередь
                                                                                       //autoreleaseFrequency это параметр выполнения памяти
                                                                                                                        //target куда ссылается после создания
                                                                                        //по сути можно не париться и параметры autoreleaseFrequency и target вообще не создавать

queue.asyncAfter(deadline: .now() + 1, execute: workItem) //блок начинает выполняться через секунду

workItem.notify(queue: .main) {   //срабатывает после выполнения блока
    print("workitem is completed!")
}

workItem.isCancelled //отменен ли блок
workItem.cancel()    //отменяем блок
workItem.isCancelled

workItem.wait()      //ждем выполнение кода в блоке, программа не будет дальше выполняться













