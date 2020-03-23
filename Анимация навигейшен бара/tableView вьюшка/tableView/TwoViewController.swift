//
//  TwoViewController.swift
//  tableView
//
//  Created by Hudihka on 17/08/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class TwoViewController: SupportViewController, UITableViewDelegate, UITableViewDataSource {

    var text:String = "nou"

    @IBOutlet weak var tableView: UITableView!
    var dataArray:[String] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        tableView.delegate = self
        tableView.dataSource = self
        self.title = text

    }

    func getData(){
        for _ in 0...50{
            let value = arc4random_uniform(500)
            self.dataArray.append("TWO" + String(value))
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.red
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }



    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        self.animationNavigBar(scrollView: scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.stoppedScrolling()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.stoppedScrolling()
        }
    }

}
