//
//  ViewController.swift
//  tableView
//
//  Created by Hudihka on 31/05/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class ViewController: SupportViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    var dataArray:[String] = []

    @IBOutlet weak var viewContentScroll: UIView!
    @IBOutlet weak var downCostreint: NSLayoutConstraint!


    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "title"


        //вьюшка добавленная через стториборды, коорую мы и хоттим двигать
        self.animateView = viewContentScroll

        //скрол вью вьюшка добавленная через стториборды, на движения которой реагируе навиг бар
        self.scrollViewContent = tableView
        /*учти, что в таких ситтуациях образуется противный засвет в низу. Костыль ниже спец для этого */


    }



    func getData(){
        //применять если хотим показывать табл под навиг баром
//        if #available(iOS 11.0, *) {
//            self.tableView.contentInsetAdjustmentBehavior = .never
//        } else {
//            self.automaticallyAdjustsScrollViewInsets = false
//        }

        for _ in 0...50{
            let value = arc4random_uniform(500)
            self.dataArray.append(String(value))
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storubord = UIStoryboard(name: "Main", bundle: nil)
        let VC = storubord.instantiateViewController(withIdentifier: String(describing: TwoViewController.self)) as! TwoViewController
        VC.text = dataArray[indexPath.row]
        self.navigationController?.pushViewController(VC, animated: true)
    }



    //методы ответственные за анимацию нав бара

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

