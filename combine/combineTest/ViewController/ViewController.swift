//
//  ViewController.swift
//  combine
//
//  Created by Константин Ирошников on 11.06.2022.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var labelAll: UILabel!
    private var observer: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()

        observer = ManagerCounter.shared.$counter.sink(receiveValue: { value in
            self.labelAll.text = "Всего \(value)"
        })
    }

    @IBAction func goAction(_ sender: Any) {
        present(Builder.generateVC1(), animated: true, completion: nil)
    }

}

