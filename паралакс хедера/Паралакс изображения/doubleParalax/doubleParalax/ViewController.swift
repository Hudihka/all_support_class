//
//  ViewController.swift
//  doubleParalax
//
//  Created by Hudihka on 18/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var heder: HederView?
    var dataArray: [String] = ["Красный", "Синий", "Зеленый",
                                "Красный", "Синий", "Зеленый",
                                "Красный", "Синий", "Зеленый",
                                "Красный", "Синий", "Зеленый",
                                "Красный", "Синий", "Зеленый",
                                "Красный", "Синий", "Зеленый",
                                "Красный", "Синий", "Зеленый",
                                "Красный", "Синий", "Зеленый",
                                "Красный", "Синий", "Зеленый",
                                "Красный", "Синий", "Зеленый"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.hedersTableView(koef: 1, image: UIImage(named: "img_1"))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
        
        
        heder = tableView.tableHeaderView as? HederView

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }

}

extension ViewController: UITableViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        heder?.paralax(scrollView: scrollView)
    }
}


