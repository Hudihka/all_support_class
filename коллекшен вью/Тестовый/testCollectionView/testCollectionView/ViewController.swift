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
        addDADGesture()
        
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


        cell.name = dataArray[indexPath.row]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = wDdevice/3
        return CGSize(width: size, height: size)
    }
    
    //MARK - DragAndDrop
    
    func addDADGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self,
                                                            action: #selector(self.handleLongGesture(gesture:)))
        longPressGesture.minimumPressDuration = 0.25
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        moveItemAt sourceIndexPath: IndexPath,
                        to destinationIndexPath: IndexPath) {
        
        let item = dataArray.remove(at: sourceIndexPath.item)
        dataArray.insert(item, at: destinationIndexPath.item)
    }
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {

        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    

}



