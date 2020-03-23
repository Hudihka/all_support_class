//
//  ViewController.swift
//  tableView
//
//  Created by Hudihka on 31/05/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //код взят отсюда
    //https://github.com/bfeher/BFPaperTableViewCell

    @IBOutlet weak var tableView: UITableView!
    var dataArray:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "СustomTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }

    func getData(){
        for _ in 0...50{
            let value = arc4random_uniform(500)
            self.dataArray.append(String(value))
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! СustomTableViewCell
        cell.labelCell.text = dataArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
    }


}

