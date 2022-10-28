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
        for _ in 0...80{
            dataArray.append(objImg())
        }
    }
    
    private func objImg() -> UIImage{
        let number = arc4random_uniform(94)
        return UIImage(named: "img_\(number)") ?? UIImage()
    }
    

}


extension ViewController: CustomLayoutDelegate, UICollectionViewDataSource {
    
    
    private func sizeUIImmage(_ indexPath: IndexPath) -> CGFloat{
        
        let image = dataArray[indexPath.row]
        let heightImage = image.size.height
        
        return heightImage / 7
        
//        if heightImage < 150 {
//            return heightImage
//        } else if heightImage <= 150 && heightImage < 1000 {
//            return heightImage / 6
//        } else {
//            return 180
//        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        heightForItemAt indexPath: IndexPath,
                        with width: CGFloat) -> CGFloat {
        
        return sizeUIImmage(indexPath)
        
    }
    

    // MARK: - CollectionView
    
    
    public var customCollectionViewLayout: UICustomCollectionViewLayout? {
        get {
            return self.collectionView?.collectionViewLayout as? UICustomCollectionViewLayout
        }
        set {
            if newValue != nil {
                self.collectionView?.collectionViewLayout = newValue!
            }
        }
    }
    

    func settingsCV() {
        
        self.collectionView.dataSource = self
        self.customCollectionViewLayout?.delegate = self
        self.customCollectionViewLayout?.numberOfColumns = 2 //число столбцов
        
        //self.customCollectionViewLayout?.cellPadding = 30

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




}



