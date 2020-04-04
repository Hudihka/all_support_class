//
//  CustomController.swift
//  paralax
//
//  Created by Hudihka on 05/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class CustomController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	fileprivate var dataArray = [String]()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		for _ in 0...30{
			let number = arc4random()
			dataArray.append("\(number)")
		}
		
		desingTV()
    }
    

    static func route() -> CustomController {
		
		let storubord = UIStoryboard(name: "Main", bundle: nil)
		let VC = storubord.instantiateViewController(identifier: "CustomController")
		
		
		return VC as! CustomController
	}

}


extension CustomController: UITableViewDelegate, UITableViewDataSource{
	
	fileprivate func desingTV(){
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		
		
		cell.textLabel?.text = dataArray[indexPath.row]
		
		return cell
	}
	
	
}
