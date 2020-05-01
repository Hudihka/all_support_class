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
		
		let rect = CGRect(x: 0,
						  y: 0,
						  width: tableView.frame.width,
						  height: 0)
		
		refreshView = RefreshView(frame: rect)

		refreshView?.block = {
			self.refresh.endRefreshing()
		}
		
		self.tableView.tableHeaderView = refreshView
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
		
		guard let refreshView = refreshView else {
			return
		}
		
		let offset = scrollView.contentOffset.y
		
		if refreshView.blockUpConstreint, offset >= -100{
			return
		} else {
			print("---------------------------")
			refreshView.offset = scrollView.contentOffset.y
		}
		
	}
	
	
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		guard let refreshView = refreshView else {
			return
		}
		
		let offset = scrollView.contentOffset.y
		
		if refreshView.blockUpConstreint == false, refreshView.animateCirkles, offset <= -100{
			print("block")
			refreshView.blockUpConstreint = true
			
			let rect = CGRect(x: 0,
							  y: 0,
							  width: tableView.frame.width,
							  height: 100)
			
			refreshView.frame = rect
		}
	}

}

