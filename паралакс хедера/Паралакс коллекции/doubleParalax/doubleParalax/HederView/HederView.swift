//
//  HederView.swift
//  doubleParalax
//
//  Created by Hudihka on 18/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import Foundation
import UIKit

class HederView: UIView{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var conteinerView: UIView!

    @IBOutlet private var horizontalConstreints: [NSLayoutConstraint]!
    @IBOutlet private weak var downConstrein: NSLayoutConstraint!
    @IBOutlet private weak var upConstreint: NSLayoutConstraint!
    
    private var downParalaxArray = [NSLayoutConstraint]()
    
    @IBOutlet weak var imageContent: UIImageView!
    
    var dataArray: [UIImage]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    
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
        conteinerView = loadViewFromNib("HederView")
        conteinerView.frame = bounds
        conteinerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(conteinerView)
    }

    private func settingsView() {
        self.downParalaxArray += horizontalConstreints
        self.downParalaxArray.append(upConstreint)
        
        desingCollection()
    }
    
    
    func paralax(scrollView: UIScrollView) {
        let delta: CGFloat = scrollView.contentOffset.y
        
        addSettings(deltaNegative: delta < 0)
        if delta < 0 {
            swipeDownParalax(delta: delta)
        } else if delta > 0{
            swipeUpParalax(delta: delta / 2)
        } else { //== 0
            
        }
        
    }
    
    
    private func swipeDownParalax(delta: CGFloat){
        
        for obj in downParalaxArray {
            obj.constant = delta
        }
    }
    
    private func swipeUpParalax(delta: CGFloat){
        
        upConstreint.constant = delta
        downConstrein.constant = -1 * delta
        
    }
    
    private func addSettings(deltaNegative: Bool){
        if deltaNegative, clipsToBounds{
            clipsToBounds = false
        } else if !clipsToBounds, !deltaNegative{
            clipsToBounds = true
        }
    }


    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}


extension HederView: UICollectionViewDataSource{//, UICollectionViewDelegateFlowLayout {
    
    private func desingCollection(){
        
        /*ЗДЕСЬ*/
        
        collectionView.dataSource = self
//        collectionView.delegate = self
        
        collectionView.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        collectionView.register(CellCollection.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView.isScrollEnabled = (dataArray?.count ?? 0) > 1
        
        let flowLayout = UICollectionViewFlowLayout()

        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = collectionView.frame.size

        collectionView.collectionViewLayout = flowLayout
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray?.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellCollection

        cell.newImage = dataArray?[indexPath.row]

        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return collectionView.frame.size
//    }

}

