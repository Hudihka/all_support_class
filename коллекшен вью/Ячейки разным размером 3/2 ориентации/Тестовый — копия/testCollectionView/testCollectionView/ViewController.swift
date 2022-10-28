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
    var dataArray = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        settingsCV()
        
    }
    
    private func getData(){
        for i in 0...49{
            dataArray.append(objImg(number: i))
        }
    }
    
    private func objImg(number: Int) -> String{
        return "img_\(number)"
    }
    
    
    private func reloadCV(add: Bool){
        
        if add{
            let number = arc4random_uniform(50)
            let obj = objImg(number: Int(number))
            dataArray.append(obj)
        } else if !dataArray.isEmpty {
            dataArray.remove(at: 0)
        }
    }
    
    //MARK: - Смена ориентации
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        reloadLayer()
    }
    
    func reloadLayer() {
        collectionView.collectionViewLayout.invalidateLayout()
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.clearCache()
        }
        collectionView.layoutIfNeeded()
    }

}


extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    // MARK: - CollectionView

    func settingsCV() {
        
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }
        self.collectionView.dataSource = self
        self.collectionView.delegate = self

        self.collectionView.register(UINib(nibName: "MyCustomCell", bundle: nil),
                                     forCellWithReuseIdentifier: "MyCustomCell")
        
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MyCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCustomCell", for: indexPath) as! MyCustomCell

        cell.name = dataArray[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        dataArray.remove(at: indexPath.row)
        
        collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [indexPath])
        }) { _ in
            self.reloadLayer()
        }
    }
    
}

extension ViewController: PinterestLayoutDelegate {
    
  func collectionView(_ collectionView: UICollectionView,
      heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    
    
    let name = dataArray[indexPath.row]
    if let image = UIImage(named: name) {
        return image.size.height / 5
    }
    return 180
  }
}



