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
			let name = objImg(number: i)
			let image = UIImage(named: name) ?? UIImage()
            dataArray.append(image)
        }
    }
    
    private func objImg(number: Int) -> String{
        return "img_\(number)"
    }
    
    
    private func reloadCV(add: Bool){
        
        if add{
            let number = arc4random_uniform(50)
            let name = objImg(number: Int(number))
			let obj = UIImage(named: name) ?? UIImage()
            dataArray.append(obj)
        } else if !dataArray.isEmpty {
            dataArray.remove(at: 0)
        }
    }
    
    
    // MARK - Action
    
    @IBAction func deleteCell(_ sender: Any) {
        self.reloadCV(add: false)
        let index = IndexPath(row: 0, section:0)
        
        collectionView.performBatchUpdates({
            
            self.collectionView.deleteItems(at:[index])
        }, completion: nil)
    }
    
    
    @IBAction func addCell(_ sender: Any) {
        self.reloadCV(add: true)
        let index = IndexPath(row: dataArray.count - 1, section: 0)
        
        collectionView.performBatchUpdates({
            self.collectionView.insertItems(at: [index])
        }, completion: nil)
    }
    

}


extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    // MARK: - CollectionView

    func settingsCV() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.dragInteractionEnabled = true

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
		
		PageViewController.presentPageVC(self, startIndex: indexPath.row, countVC: dataArray.count)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = wDdevice/3
        return CGSize(width: size, height: size)
    }
    
    

}



