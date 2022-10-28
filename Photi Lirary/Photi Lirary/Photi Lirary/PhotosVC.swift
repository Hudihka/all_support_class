//
//  PhotosVC.swift
//  Photi Lirary
//
//  Created by Hudihka on 18/07/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

protocol ProtocolPhotoSelection {
    func newYourImage(image: UIImage)
}

class PhotosVC: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!

    let imgManager = ManagerLibsUserPhoto.shared
    var delegate: ProtocolPhotoSelection?

    override func viewDidLoad() {
        super.viewDidLoad()

        settingsCV()
    }

    static func route() -> PhotosVC? {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PhotosVC")
        let controller = viewController as? PhotosVC

        return controller
    }

    @IBAction func dismisButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - CollectionView

    func settingsCV() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        self.collectionView.register(UINib(nibName: CollectionCellPhotos.className, bundle: nil),
                                     forCellWithReuseIdentifier: CollectionCellPhotos.className)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgManager.reqwestResult().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CollectionCellPhotos =
            collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellPhotos.className,
                                               for: indexPath) as? CollectionCellPhotos
            else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellPhotos.className, for: indexPath)
                return cell
        }

        cell.index = indexPath
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        toSendPhoto(indexPath)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 1
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    private func toSendPhoto(_ index: IndexPath) {
        if let cell = collectionView(collectionView, cellForItemAt: index) as? CollectionCellPhotos, let image = cell.imageCell.image {
            delegate?.newYourImage(image: image)
        }
    }

    deinit {
        imgManager.clearCash()
    }
}

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
