//
//  ViewController.swift
//  testCollectionView
//
//  Created by Hudihka on 06/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataArray = [UIImage]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        settingsCV()
        
    }
    
    private func getData(){
        for i in 0...49{
			let name = "img_\(i)"
			let image = UIImage(named: name) ?? UIImage()
            dataArray.append(image)
        }
    }
    

}


extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	
	// MARK: - CollectionView
	
	func settingsCV() {
		self.collectionView.delegate = self
		self.collectionView.dataSource = self
		
		self.collectionView.register(UINib(nibName: "MyCustomCell", bundle: nil),
									 forCellWithReuseIdentifier: "MyCustomCell")
		
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: MyCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCustomCell", for: indexPath) as! MyCustomCell
		
		
		cell.image = dataArray[indexPath.row]
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView,
						didSelectItemAt indexPath: IndexPath) {
		
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let size = wDdevice/3
		return CGSize(width: size, height: size)
	}
	
	//MARK: Context menu
	
	
	func collectionView(_ collectionView: UICollectionView,
						contextMenuConfigurationForItemAt indexPath: IndexPath,
						point: CGPoint) -> UIContextMenuConfiguration? {
			
			let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil){ action in
				
				/*
				state
				
				если поставить on то будет галочка
				
				case off Константа, указывающая, что элемент меню находится в выключенном состоянии.
				case on Константа, указывающая, что элемент меню находится во включенном состоянии.
				case mixed Константа, указывающая, что элемент меню находится в «смешанном» состоянии.
				*/
				
				let viewMenu = UIAction(title: "View",
										image: UIImage(named: "img_\(indexPath.row)"), //создаем кастомное изображение
										identifier: UIAction.Identifier(rawValue: "view")) {_ in
					print("button clicked..")
				}
				
				let rotate = UIAction(title: "Rotate",
									  image: UIImage(systemName: "arrow.counterclockwise"),
									  identifier: nil,
									  state: .off,
									  handler: {action in
					print("rotate clicked.")
				})
				
				/*
				attributes
				
				attributes: .disabled      бледно серый цвет
				attributes: .destructive   крассный цвет
				
				*/
				
				let delete = UIAction(title: "Delete",
									  image: UIImage(systemName: "trash.fill"),
									  identifier: nil,
									  discoverabilityTitle: nil,
									  attributes: .destructive,
									  state: .off,
									  handler: {action in
					
										self.dataArray.remove(at: indexPath.row)
										self.collectionView.reloadData()
				})
				
				let editMenu = UIMenu(title: "Edit...", //под меню, при его нажатии открывается новое контекстное меню
									  children: [rotate, delete])
				
				
				return UIMenu(title: "ТИТУЛЬНИК", image: nil, identifier: nil, children: [viewMenu, editMenu])
			}
			
			return configuration
	}
	
}



