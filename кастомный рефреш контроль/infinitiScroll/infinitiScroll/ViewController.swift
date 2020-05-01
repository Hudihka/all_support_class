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
	
	var refresh = UIRefreshControl()
	var refreshView: RefreshView?

    var dataArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        addData(30)
		
		
        desingTV()
		createRefreshView()
    }
	
	private func createRefreshView(){
//
//		refresh.tintColor = .clear
//		refresh.backgroundColor = .clear
				
		tableView.addSubview(refresh)
//		refreshView = RefreshView(frame: refresh.frame)
//
//		refreshView?.block = {
//			self.refresh.endRefreshing()
//		}
//
//		refresh.addSubview(refreshView!)
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
		
		cell.contentView.backgroundColor = .red

        return cell
    }
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		refreshView?.stopedAnimateRotate()
	}
	
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		refreshView?.offset = scrollView.contentOffset.y
	}

}

