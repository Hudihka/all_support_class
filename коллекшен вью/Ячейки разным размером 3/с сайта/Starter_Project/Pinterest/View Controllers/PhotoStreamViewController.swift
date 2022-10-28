

import UIKit
import AVFoundation

class PhotoStreamViewController: UICollectionViewController {
  var photos = Photo.allPhotos()
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
      layout.delegate = self
    }
    
    if let patternImage = UIImage(named: "Pattern") {
      view.backgroundColor = UIColor(patternImage: patternImage)
    }
    collectionView?.backgroundColor = .clear
    collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
  }
}

extension PhotoStreamViewController: UICollectionViewDelegateFlowLayout {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnnotatedPhotoCell", for: indexPath as IndexPath) as! AnnotatedPhotoCell
    cell.photo = photos[indexPath.item]
    return cell
  }
  
  //это не надо по ходу
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    
//    let itemSize = (collectionView.frame.width -
//      (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
//    
//    return CGSize(width: itemSize, height: itemSize)
//  }
}

//возвращаем размер изображения
extension PhotoStreamViewController: PinterestLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView,
      heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    return photos[indexPath.item].image.size.height
  }
}
