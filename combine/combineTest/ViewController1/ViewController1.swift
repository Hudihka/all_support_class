//
//  ViewController1.swift
//  combine
//
//  Created by Константин Ирошников on 11.06.2022.
//

import UIKit
import Combine

class ViewController1: UIViewController {
    @IBOutlet weak var labelAll: UILabel!

    private var observer: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()

        observer = ManagerCounter.shared.$counter
            .sink(receiveValue: { value in
            self.labelAll.text = "Всего \(value)"
        })
    }

    @IBAction func goAction(_ sender: Any) {
        present(Builder.generateVC2(), animated: true, completion: nil)
    }

    @IBAction func addAction(_ sender: Any) {
        ManagerCounter.shared.addCounter()
    }
}
