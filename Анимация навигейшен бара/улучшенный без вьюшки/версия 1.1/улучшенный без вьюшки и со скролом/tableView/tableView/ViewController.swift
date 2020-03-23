//
//  ViewController.swift
//  tableView
//
//  Created by Hudihka on 31/05/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class ViewController: SupportViewController, UITableViewDelegate, UITableViewDataSource {



    var textTitle = "title"
    @IBOutlet weak var tableView: UITableView!
    var dataArray:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        tableView.delegate = self
        tableView.dataSource = self
        self.title = textTitle

    }


    // MARK: - Sustem
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.goNextVC()
    }

    func getData(){
        //применять если хотим показывать табл под навиг баром
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }

        for _ in 0...5{
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
        self.stoppedScrolling(scrollView: scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.stoppedScrolling(scrollView: scrollView)
        }
    }


}

