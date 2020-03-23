//
//  TwoViewController.swift
//  tableView
//
//  Created by Hudihka on 09/06/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController {
    @IBOutlet weak var label:UILabel!
    var human: Human? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        title = human?.name
        self.label.text = human?.name ?? "нет"

        navigationItem.largeTitleDisplayMode = .never //делает наш титульник обычным

    }

}
