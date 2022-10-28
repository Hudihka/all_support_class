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
    
    var indexBigPhoto: IndexPath? = nil
    private var bigRequest: PHImageRequestID? = nil
    private let size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)

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
        
        if let loadIndex = indexBigPhoto{ //защита от повторного
            
            if loadIndex == indexPath {
                return
            }
            
            if let bigRequest = bigRequest {
                self.imgManager.cancelImageRequest(bigRequest)
                indexBigPhoto = nil
            }
            
        }
        
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.indexBigPhoto = indexPath
            self.bigRequest = self.imgManager.requestImage(for: self.fetchResult.object(at: indexPath.row),
                                                           targetSize: self.size,
                                                           contentMode: .aspectFill,
                                                           options: self.requestOption) { (image, _) in
                                                            DispatchQueue.main.async {
                                                                self.indexBigPhoto = nil
                                                                if let img = image {
                                                                    completion(img)
                                                                }
                                                            }
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




}

extension IndexPath {

    var keyCashIndex: NSString {
        return "Это_ключ_кэш_памяти_\(self.section)-\(self.row)" as NSString
    }

}

