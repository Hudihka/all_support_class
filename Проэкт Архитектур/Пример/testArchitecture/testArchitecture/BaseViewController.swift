//
//  ViewController.swift
//  testArchitecture
//
//  Created by Константин Ирошников on 14.09.2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(
            red: 242/255, green: 222/255, blue: 166/255, alpha: 0.5
        )
        listenViewModel()
        layoutVC()
    }

    func listenViewModel() {}

    func layoutVC() {}

}

