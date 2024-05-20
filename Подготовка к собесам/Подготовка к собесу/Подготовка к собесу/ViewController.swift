//
//  ViewController.swift
//  Подготовка к собесу
//
//  Created by Худышка К on 14.05.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.layer.backgroundColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        view.backgroundColor = .yellow
        
    }
    
    @IBAction func taped(_ sender: Any) {
        let VC2 = ViewController2()
        self.navigationController?.pushViewController(VC2, animated: true)
    }
    
}


private class ViewController2: UIViewController {
    
    let example = "0000"
    
    var text: String {
        print("text")
        
        return ""
    }
    
    var text2: String = {
        print(arc4random())
        
        return "09"
    }()
    
    lazy var text3: String = {
        
        print("text3")
        
        return text3
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        
//        let _ = text
//        let _ = text2
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("----0")
            print(self.text2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("----1")
            print(self.text3)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("----2")
            print(self.text3)
        }
    }

}
