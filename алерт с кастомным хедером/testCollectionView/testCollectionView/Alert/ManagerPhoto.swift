//
//  ManagerPhoto.swift
//  testCollectionView
//
//  Created by Админ on 03.08.2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import Foundation
import Photos
import UIKit

class ManagerPhotos: NSObject{

    static let shared = ManagerPhotos()
    let imageCache = NSCache<NSString, UIImage>()

    let height = 100
    private let imgManager = PHImageManager.default()

    private var option: PHFetchOptions {
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        return fetchOption
    }

    var fetchResult: PHFetchResult<PHAsset> {
        return PHAsset.fetchAssets(with: .image, options: option)
    }

    var requestOption: PHImageRequestOptions{
        let requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
        requestOption.deliveryMode = .highQualityFormat

        return requestOption
    }


    func getImageBig(indexPath: IndexPath, completion: @escaping (UIImage) -> Void){

        let size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)

        imgManager.requestImage(for: fetchResult.object(at: indexPath.row),
                                targetSize: size,
                                contentMode: .aspectFill,
                                options: requestOption) { (image, _) in
                                    if let img = image {
                                        completion(img)
                                    }
        }
    }

    func getImageOne(indexPath: IndexPath, completion: @escaping (UIImage) -> Void){

        let key = indexPath.keyCashIndex

        if let imgCash = imageCache.object(forKey: key){
            completion(imgCash)
            return
        }

        let size = CGSize(width: height, height: height)

        DispatchQueue.global(qos: .userInitiated).async {
            self.imgManager.requestImage(for: self.fetchResult.object(at: indexPath.row),
                                    targetSize: size,
                                    contentMode: .aspectFill,
                                    options: self.requestOption) { (image, _) in
                                        if let img = image {
                                            self.imageCache.setObject(img, forKey: key)
                                            DispatchQueue.main.async {
                                                completion(img)
                                            }
                                        }
            }
        }
    }






//    func requestAllImagesFromLibrary(){
//
//        let size = CGSize(width: height, height: height)
//
//        if fetchResult.count > 0 {
//            for i in 0..<fetchResult.count {
//                imgManager.requestImage(for: fetchResult.object(at: i),
//                                        targetSize: size,
//                                        contentMode: .aspectFill,
//                                        options: requestOption) { (image, _) in
//                                            print("index \(i)")
//                                            if let img = image {
//                                                self.imageArray.append(img)
//                                            }
//                }
//            }
//        }
//    }



}

extension IndexPath {

    var keyCashIndex: NSString {
        return "Это_ключ_кэш_памяти_\(self.section)-\(self.row)" as NSString
    }

}
