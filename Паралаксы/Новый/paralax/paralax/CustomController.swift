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
		
		tableView.addHederShadowView(image: UIImage(named: "testIMG"), koef: 0.65)
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


extension UITableView{
	
	// один из параметров должен быть обяз не опциональный
	func addHederShadowView(image: UIImage?, height: CGFloat?){
		
		if self.tableHeaderView == nil {
			
			guard let heightHeader = height ?? image?.getHeightUIImage(width: self.frame.width) else {
				return
			}
			
			let hederViewCustom = Header(heightHeader: heightHeader,
										image: image,
										superView: self)
			
			self.tableHeaderView = hederViewCustom
			
		}
	}
	
//	если koef == 1 то высота хедера == ширине
//	если koef == 0.5 то высота хедера == ширине * 0.5
	
	func addHederShadowView(image: UIImage?, koef: CGFloat){
		
		if self.tableHeaderView == nil {
			
			let heightHeader = self.frame.width * koef
			
			let hederViewCustom = Header(heightHeader: heightHeader,
										image: image,
										superView: self)
			
			self.tableHeaderView = hederViewCustom
			
		}
	}
}
