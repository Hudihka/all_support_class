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
		
		desingCollection()
	}


}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	
	
	fileprivate func desingCollection(){
		
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.backgroundColor = UIColor.clear
		
		let cellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
		collectionView.register(cellNib, forCellWithReuseIdentifier: "Cell")
		
	}
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataArray.count
	}
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
		
		cell.name = dataArray[indexPath.row]
		
		return cell
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		
		let name = dataArray[indexPath.row]
		let VC = TwoViewController.route(imageName: name)
		
		self.present(VC, animated: true, completion: nil)
		
	}
	
	//MARK: Слои
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: wDdevice, height: wDdevice + 20)
		
	}
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout
		collectionViewLayout: UICollectionViewLayout,
						minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	//MARK: - Анимация ячеек
	
	func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
		
		self.animate(index: indexPath) { (view) in
			view.transform = .init(scaleX: 0.95, y: 0.95)
		}
		
	}

	func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
		
		self.animate(index: indexPath) { (view) in
			view.transform = .identity
		}
		
	}
	
	
	private func animate(index: IndexPath, animationsBlock:@escaping(TransformViewCollection) -> Void){
		
		UIView.animateKeyframes(withDuration: 0.5,
								delay: 0,
								options: [.calculationModePaced],
								animations: {
									
									if let cell = self.collectionView.cellForItem(at: index) as? CollectionViewCell, let view = cell.transformView {
										animationsBlock(view)
									}
									
		},
								completion: nil)
		
	}
	
	
	
	
}

