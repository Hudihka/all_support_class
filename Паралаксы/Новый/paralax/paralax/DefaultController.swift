//
//  DefaultController.swift
//  paralax
//
//  Created by Hudihka on 05/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class DefaultController: UIViewController {
	
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
    
	static func route() -> DefaultController {
		
		let storubord = UIStoryboard(name: "Main", bundle: nil)
		let VC = storubord.instantiateViewController(identifier: "DefaultController")
		
		
		return VC as! DefaultController
	}

}

extension DefaultController: UITableViewDelegate, UITableViewDataSource{
	
	fileprivate func desingTV(){
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		
		tableView.addHederView(image: UIImage(named: "testIMG"), koef: 0.5)
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
	func addHederView(image: UIImage?, height: CGFloat?){
		
		if self.tableHeaderView == nil {
			
			guard let heightHeader = height ?? image?.getHeightUIImage(width: self.frame.width) else {
				return
			}
			
			let hederViewCustom = HederView(heightHeader: heightHeader,
											image: image,
											superView: self)
			
			self.tableHeaderView = hederViewCustom
			
		}
	}
	
//	если koef == 1 то высота хедера == ширине
//	если koef == 0.5 то высота хедера == ширине * 0.5
	
	func addHederView(image: UIImage?, koef: CGFloat){
		
		if self.tableHeaderView == nil {
			
			let heightHeader = self.frame.width * koef
			
			let hederViewCustom = HederView(heightHeader: heightHeader,
											image: image,
											superView: self)
			
			self.tableHeaderView = hederViewCustom
			
		}
	}
}


extension UIImage{

	func getHeightUIImage(width: CGFloat) -> CGFloat{
		
		let size = self.size

		return width * size.height / size.width

	}




}
