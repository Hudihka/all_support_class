//
//  ViewHeaderAlert.swift
//  testCollectionView
//
//  Created by Админ on 31.07.2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import Foundation
import UIKit

class ViewHeaderAlert: UIView{
    
    var indexClear = 0
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var dataArray = [String]()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        registrView()
        settingsView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        registrView()
        settingsView()
    }
    
    private func registrView() {
        
        Bundle.main.loadNibNamed("ViewHeaderAlert", owner: self, options: nil)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    private func settingsView(){
        
        self.backgroundColor = UIColor.clear
        
        getData()
        settingsCV()
        
        
    }
    
    
    private func getData(){
        for i in 0...49{
            let name = "img_\(i)"
            dataArray.append(name)
        }
    }
    
   
    
    
}


extension ViewHeaderAlert: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    // MARK: - CollectionView

    fileprivate func settingsCV() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.backgroundColor = .clear

        self.collectionView.register(UINib(nibName: "MyCustomCell", bundle: nil),
                                     forCellWithReuseIdentifier: "MyCustomCell")

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MyCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCustomCell", for: indexPath) as! MyCustomCell


        cell.name = dataArray[indexPath.row]
        
        
        
        if indexPath.row > indexClear {
            cell.contentView.alpha = 0
            UIView.animate(withDuration: 0.4) {
                cell.contentView.alpha = 1
            }
             indexClear = indexPath.row
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.frame.size.height
        return CGSize(width: size + 8, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
    
    

}
