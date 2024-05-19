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
    
    var text: String {
        print("text")
        
        return ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        
        let _ = text
    }

}
