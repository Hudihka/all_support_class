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
    
    var blockOpenPhoto: (UIImage) -> () = {_ in }
    var blockOpenCamera: () -> () = {  }
    
    fileprivate var indexClear = 0
    fileprivate let photos = ManagerPhotos.shared.fetchResult
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photoAccess: Bool{
        return MultimediaOpportunities.accessAllowedPhotos
    }
    
    
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
        
        settingsCV()
    }
    
    
    deinit {
        ManagerPhotos.shared.imageCache.removeAllObjects()
    }
    
}


extension ViewHeaderAlert: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    // MARK: - CollectionView
    
    private func reloadIndex(index: IndexPath) -> IndexPath{
        
        let newIndex = IndexPath(row: index.row - 1, section: 0)
        
        return newIndex
    }
    

    fileprivate func settingsCV() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.backgroundColor = .clear
        
        if photoAccess == false {
            collectionView.isScrollEnabled = false
        }

        self.collectionView.register(UINib(nibName: "PhotoCell", bundle: nil),
                                     forCellWithReuseIdentifier: "PhotoCell")
        
        self.collectionView.register(UINib(nibName: "CameraCell", bundle: nil),
                                     forCellWithReuseIdentifier: "CameraCell")

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let photoCount = photoAccess ? photos.count : 0
        
        return 1 + photoCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            
            let cell: CameraCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CameraCell", for: indexPath) as! CameraCell
            
            return cell
            
        } else {
            
            let cell: PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
            
            cell.ind = self.reloadIndex(index: indexPath)
            
            if indexPath.row > indexClear {
                cell.contentView.alpha = 0
                UIView.animate(withDuration: 0.4) {
                    cell.contentView.alpha = 1
                }
                indexClear = indexPath.row
            }
            
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        
        if let _ = collectionView.cellForItem(at: indexPath) as? CameraCell {
            blockOpenCamera()
            return
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell {
            cell.spiner.startAnimating()
            let newIndex = reloadIndex(index: indexPath)
            ManagerPhotos.shared.getImageBig(indexPath: newIndex) {[weak self] (imageBig) in
                self?.blockOpenPhoto(imageBig)
            }
        }

    }
    
    
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.frame.size.height
        return CGSize(width: size + 8, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
    
    

}

