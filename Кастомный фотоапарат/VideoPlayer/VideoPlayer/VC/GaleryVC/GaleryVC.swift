//
//  GaleryVC.swift
//  VideoPlayer
//
//  Created by Админ on 19.08.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import UIKit

class GaleryVC: UIViewController {
    
    fileprivate var indexClear = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate let pickerVC = UIImagePickerController()
    
    fileprivate var managerPhoto = ManagerPhotos.shared
    
    fileprivate var photoAccess: Bool{
        return MultimediaOpportunities.accessAllowedPhotos
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        settingsView()
    }
    
    static func route() -> GaleryVC {
        
        let VC = EnumStoryboard.main.vc("GaleryVC")
        
        return VC as! GaleryVC
    }
    
    
    private func settingsView(){
        
        self.view.backgroundColor = UIColor.white
        self.title = "Галерея"
        
        let RBBI = UIBarButtonItem(title: "Альбомы", style: .plain, target: self, action: #selector(openAlboms))
        self.navigationItem.rightBarButtonItem = RBBI
        
        settingsCV()
    }
    
    @objc func openAlboms(){
        self.openAlbom(pickerVC: pickerVC)
    }
    
    deinit {
        managerPhoto.clearCashe()
    }
    
}

extension GaleryVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    

    
    //сделал фото
    
    private func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let _ = info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage {
            //если обрезали фото
            //что делать дальше
            return
        }
        
        if let _ = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            //если обрезали фото
            //что делать дальше
            return
        }
    }
    
    
    
    
}



extension GaleryVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

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
        
        let photoCount = photoAccess ? managerPhoto.fetchResult.count : 0
        
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
            self.openCamera(pickerVC: pickerVC)
            return
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell {
            
            if managerPhoto.indexBigContent != nil { //что бы избежать ситуации когда на 2х и более ячейках спинер
                collectionView.reloadData()
            }
            cell.spiner.startAnimating()
            
            
            let newIndex = reloadIndex(index: indexPath)
            managerPhoto.getBigContent(indexPath: newIndex) {[weak self] (imageBig, video)  in
                
                if let imageBig = imageBig {
                    //open photo
                } else if let video = video {
                    let vc = PlayerViewController.route(video)
                    self?.present(vc, animated: true, completion: nil)
                }
                
                
                
                cell.spiner.stopAnimating()
            }
        }

    }
    
    
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = wDevice / 3
        return CGSize(width: size, height: size)
    }
    

}
