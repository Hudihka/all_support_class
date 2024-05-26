//
//  ViewControllerUnitTest.swift
//  test
//
//  Created by Худышка К on 13.12.2022.
//

import UIKit

class ViewControllerUnitTest: UIViewController {
    
    var presenter: ProtocolUnitTestPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = PresenterUnitTest()
    }
    
    @IBAction func firstButton(_ sender: Any) {
        firstVC(text: "PUPA")
    }
    

    @IBAction func secondButton(_ sender: Any) {
        secondVC(text: "LUPA")
    }
}

extension ViewControllerUnitTest: ProtocolUnitTestVC {
    func firstVC(text: String) {
        let str = text + "000"
        presenter?.setTextFirst(text: str)
    }
    
    func secondVC(text: String) {
        presenter?.setTextSecond(text: text)
    }
}
