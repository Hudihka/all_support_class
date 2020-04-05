//
//  ViewController.swift
//  cellAnimateCollection
//
//  Created by Hudihka on 05/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	
	fileprivate var dataArray = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		for i in 0...50{
			let name = "img_\(i)"
			dataArray.append(name)
		}
		
		
	}


}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	
	fileprivate func desingCollection(){
		
		collectionView.baseSettingsCV(obj: self,
									  clicableCell: false,
									  arrayNameCell: ["TransformCollectionViewCell"])
		
		collectionView.
	}
	
	
	

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		<#code#>
	}
	
	
}

