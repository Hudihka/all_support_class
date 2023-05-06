//
//  ViewController.swift
//  georgiaParser
//
//  Created by Худышка К on 06.03.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func tapedButton(_ sender: Any) {
        let myURLString = "https://teoria.on.ge/tickets?ticket=839"
        let vc = UrlViewController.recieptViewController(url: myURLString)
        
        self.present(vc, animated: true)
    }
    
}

