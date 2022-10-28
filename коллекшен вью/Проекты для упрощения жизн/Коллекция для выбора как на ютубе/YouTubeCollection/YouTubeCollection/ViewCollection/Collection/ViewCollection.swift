//
//  ViewCollection.swift
//  YouTubeCollection
//
//  Created by Hudihka on 13/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit
import Foundation


protocol ReloadImage: class {
    
    var image: UIImage? {get set}
}

class ViewCollection: UIView {

    @IBOutlet var counteinerView: UIView!
    
    private let dataArray = ["Цветочки", "Волк", "#Явернулся",
                             "Водопад", "Очки", "Еще цветы",
                             "РНР", "Шавки", "Еще шавки",
                             "И еще шавки", "Бухло"]
    
    private var arrayWidth = [CGFloat]()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewDown: UIView!
    
    
    var selectIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    weak var delegate: ReloadImage?

     override init (frame: CGRect) {
         super.init(frame: frame)
         xibSetup()
         settingsView()
     }

     required init(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)!
         xibSetup()
         settingsView()
     }
    
    
    private func xibSetup() {
        counteinerView = loadViewFromNib("ViewCollection")
        counteinerView.frame = bounds
        counteinerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(counteinerView )
    }

     private func settingsView() {
        
        for obj in dataArray{                                                                                   //60 это отступы
            let wCell = (obj as NSString).size(withAttributes: [NSAttributedString.Key.font :
                UIFont.boldSystemFont(ofSize: 17)]).width + 60
            arrayWidth.append(wCell)
        }
        
         newFrameViewDown()
         settingsCV()
     }

    func newFrameViewDown(){
        let width = arrayWidth[selectIndex.row]
            
        self.viewDown.frame = CGRect(x: xPosition,
                                     y: collectionView.frame.height,
                                     width: width,
                                     height: 10)
    }
    
    private var xPosition: CGFloat {
        
        let select = selectIndex.row
        let width = arrayWidth[select]
        
        if selectIndex.row == 0 {
            return 0
        }
        
        if select == arrayWidth.count - 1 {
            return DimensionsEnum.wDdevice - width
        }
        
        
        var xPointLeft: CGFloat = 0
        var xPointRight: CGFloat = 0
        
        for (index, obj) in arrayWidth.enumerated() {
            if index < select {
                xPointLeft += obj
            } else if index > select {
                xPointRight += obj
            }
            
        }
        
        let xCentr = (DimensionsEnum.wDdevice - width) / 2
        
        if xCentr < xPointLeft, xCentr < xPointRight{
            return xCentr
        } else if xCentr >= xPointLeft {
            return xPointLeft
        } else {
            return DimensionsEnum.wDdevice - xPointRight - width
        }
        
    }

     deinit {
         NotificationCenter.default.removeObserver(self)
     }

}


extension ViewCollection: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    func settingsCV(){
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.backgroundColor = UIColor.green
        
        self.collectionView.register(UINib(nibName: "Cell", bundle: nil),
                                     forCellWithReuseIdentifier: "Cell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        
        cell.model = (dataArray[indexPath.row], indexPath == selectIndex)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: arrayWidth[indexPath.row], height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath != selectIndex {
            selectIndex = indexPath
            
            self.delegate?.image = UIImage(named: dataArray[indexPath.row])
            self.collectionView.reloadData()
            
            collectionView.scrollToItem(at: selectIndex,
                                        at: .centeredHorizontally,
                                        animated: true)
            animateUpdateFramme()
        }
    }
    
    private func animateUpdateFramme(){
        
        
        UIView.animate(withDuration: 0.2) {
            self.newFrameViewDown()
        }
    }
    
    
    
}
