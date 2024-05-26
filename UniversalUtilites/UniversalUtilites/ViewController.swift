//
//  ViewController.swift
//  UniversalUtilites
//
//  Created by Худышка К on 25.05.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Пример использования
        let button = UIButton()
        button.setTitle("Tap Me", for: .normal)
        button.addAction {
            print("Button tapped!")
        }

        // Настройка внешнего вида и размещения кнопки
        button.backgroundColor = .blue
        button.frame = CGRect(x: 50, y: 50, width: 100, height: 50)

        view.addSubview(button)
    }


}
