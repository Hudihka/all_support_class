//
//  ViewController.swift
//  instaCollection
//
//  Created by Hudihka on 14/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collection: UICollectionView!
    
    var dataArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        for i in 0...90{
            dataArray.append("img_\(i)")
        }

        self.collection.dataSource = self
    }
    
}

extension ViewController: UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellCollection
        
        cell.name = dataArray[indexPath.row]
        
        return cell
    }
    
    
    
}

