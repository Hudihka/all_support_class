
//в случае дефолтной реализации выводится ВСЕГДА Что было в классе
//protocol SomeProtocol {
//    func someFunc()
//}
//
//extension SomeProtocol {
//    func someFunc() {
//        print("someFuncProtocol")
//    }
//}

//в случае такой реализации выводится в зависимости от типа что указали класс/протокол
//protocol SomeProtocol {
//}
//
//extension SomeProtocol {
//    func someFunc() {
//        print("someFuncProtocol")
//    }
//}


// индеректным может быть только энум
//indirect enum G {


//пример барьера
//let queue = DispatchQueue(label: "test.label.test.label", attributes: .concurrent)
//queue.async(flags: .barrier) {
//    array.append(i)
//}




//struct Calculator {
//    var a: Int
//    var b: Int
//    
//    
//    init(a: Int, b: Int) {
//        self.a = a
//        self.b = b
//    }
//    
//    var calculate: Int {
//        a + b
//    }
//}

//    var calc = Calculator(a: 3, b: 4)
//    let result = calc.calculate
//
//    let clouser = {
//        print("calc \(calc.calculate)")
//    }
//
//    calc.b = 10
//    clouser() // Выведет: calc 13

// для класса выведется всегда 13

// выделение памяти на массив из 10 элементов
//let n = 10
//let ptr = UnsafeMutablePointer<Int>.allocate(capacity: n)
//let buffer = UnsafeMutableBufferPointer(start: ptr, count: n)
