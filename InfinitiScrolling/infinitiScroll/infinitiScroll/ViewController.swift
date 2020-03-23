//
//  ViewController.swift
//  infinitiScroll
//
//  Created by Username on 30.12.2019.
//  Copyright © 2019 itMegastar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var dataArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        addData(30)

        desingTV()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        tableView.addInfiniteScrolling {
            print("поехали")
            self.stopInfinitiScrolling()
        }

                tableView.infiniteScrollingView.activityIndicatorViewStyle = .whiteLarge
                tableView.infiniteScrollingView.tintColor = UIColor.blue
                tableView.infiniteScrollingView.backgroundColor = UIColor.green

        tableView.triggerInfiniteScrolling()

    }

    private func stopInfinitiScrolling(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.tableView.stopedInfinitiSpiner()
        }
    }


    func addData(_ count: Int){

        var newData: [String] = []

        for _ in 0...count - 1 {
            newData.append("_")
        }

        dataArray = dataArray + newData

    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{

    func desingTV(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "индекс \(indexPath.row + 1)"

        return cell
    }

}

extension UIScrollView{
    func stopedInfinitiSpiner(){
        self.infiniteScrollingView.stopAnimating()
        self.showsInfiniteScrolling = false
        self.showsInfiniteScrolling = true
    }
}
