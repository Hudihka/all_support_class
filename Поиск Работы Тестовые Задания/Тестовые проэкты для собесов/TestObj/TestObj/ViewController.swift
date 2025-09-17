//
//  ViewController.swift
//  TestObj
//
//  Created by Konstantin I on 03.06.2025.
//

import UIKit

class YellowView: UIView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("yellowView touched!")
    }
}

class ViewController: UIViewController {
    
    private var blueView = UIView()
    private var redView = UIView()
    private var yellowView = YellowView()
    private let testObjectName = "------"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var testObject: TestClass? = TestClass()
        testObject?.name = testObjectName
        testObject?.test()
        testObject = nil
        
        var array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        print(
            filterEven(array: &array)
        )
        
        
        
        
        
        
        blueView = UIView(frame: CGRect(x: 50, y: 250, width: 300, height: 200))
        blueView.backgroundColor = .systemBlue
        view.addSubview(blueView)
//        blueView.clipsToBounds = true
        
        blueView.layer.zPosition

        redView = UIView(frame: CGRect(x: 50, y: 50, width: 150, height: 350))
        redView.backgroundColor = .systemRed
        blueView.addSubview(redView)

        yellowView = YellowView(frame: CGRect(x: 50, y: 200, width: 50, height: 50))
        yellowView.backgroundColor = .systemYellow
        redView.addSubview(yellowView)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let yellowViewTouch = touch.location(in: yellowView)
        
        print(touch.location(in: yellowView))

        if touch.view === blueView { print("Blue view") }
        if touch.view === redView { print("Red view") }
        if touch.view === yellowView { print("Yellow view") }
        

        if ![redView, blueView, yellowView].contains(touch.view) {
            print("Background view")
        }
    }
}

extension ViewController {
    func filterEven(array: inout [Int]) -> [Int] {
        var index = array.count - 1
        
        while index > -1 {
            if array[index] % 2 == 0 {
                array.remove(at: index)
            }
            
            index -= 1
        }
        
        return array
    }
}

extension Collection {
    func groupBy<T: Hashable>(_ compl: (Element) -> T) -> [T: [Element]]{
        var returnDictionary = [T: [Element]]()
        
        self.forEach {
            let value = compl($0)
            
            if var array = returnDictionary[value] {
                array.append($0)
                returnDictionary[value] = array
            } else {
                returnDictionary[value] = [$0]
            }
        }
        
        return returnDictionary
    }
}

struct KeyObj: Hashable {
    let a: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
}
