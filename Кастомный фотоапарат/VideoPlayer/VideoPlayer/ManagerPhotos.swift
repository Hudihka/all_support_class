//
//  ManagerPhotos.swift
//  VideoPlayer
//
//  Created by Админ on 19.08.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import Foundation
import Photos
import UIKit

class ManagerPhotos: NSObject{
    
    static let shared = ManagerPhotos()
    let imageCache = NSCache<NSString, UIImage>()
    let durationCache = NSCache<NSString, NSString>()
    
    var indexBigContent: IndexPath? = nil
    private var bigRequest: PHImageRequestID? = nil
    private let size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)

    private let imgManager = PHImageManager.default()

    private var option: PHFetchOptions {
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "modificationDate", ascending: false)]
        fetchOption.predicate = NSPredicate(format: "mediaType == %d || mediaType == %d", PHAssetMediaType.image.rawValue,
                                                                                          PHAssetMediaType.video.rawValue)
        
        return fetchOption
    }

    var fetchResult: PHFetchResult<PHAsset> {
        return PHAsset.fetchAssets(with: option)
    }

    private var requestImageOption: PHImageRequestOptions{
        let requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
        requestOption.deliveryMode = .highQualityFormat

        return requestOption
    }
    
    private var requestVideoOption: PHVideoRequestOptions{
        let requestOption = PHVideoRequestOptions()
        requestOption.isNetworkAccessAllowed = true
        requestOption.deliveryMode = .highQualityFormat

        return requestOption
    }


    func getBigContent(indexPath: IndexPath, completion: @escaping (UIImage?, AVPlayerItem?) -> Void){

        if let loadIndex = indexBigContent{ //защита от повторного тапа

            if loadIndex == indexPath {
                return
            }

            if let bigRequest = bigRequest {
                self.imgManager.cancelImageRequest(bigRequest)
                indexBigContent = nil
            }

        }


        DispatchQueue.global(qos: .userInteractive).async {
            self.indexBigContent = indexPath
            let obj = self.fetchResult.object(at: indexPath.row)

            if obj.mediaType == .video {
                //получение видео
                
                self.bigRequest = self.imgManager.requestPlayerItem(forVideo: obj,
                                                                    options: self.requestVideoOption,
                                                                    resultHandler: { (item, _) in
                                                                        DispatchQueue.main.async {
                                                                            if let item = item {
                                                                                completion(nil, item)
                                                                            }
                                                                        }
                                                                    })



            } else {
                //получение изображения

                self.bigRequest = self.imgManager.requestImage(for: obj,
                                                               targetSize: self.size,
                                                               contentMode: .aspectFill,
                                                               options: self.requestImageOption) { (image, _) in
                                                                DispatchQueue.main.async {
                                                                    self.indexBigContent = nil
                                                                    if let img = image {
                                                                        completion(img, nil)
                                                                    }
                                                                }
                }
            }


        }
    }

    func getImageOne(indexPath: IndexPath, completion: @escaping (UIImage, String?) -> Void){

        let key = indexPath.keyCashIndex
        let keyDuration = indexPath.keyCashIndexDuration

        if let imgCash = imageCache.object(forKey: key){
            
            if let duration = durationCache.object(forKey: keyDuration) as String?{
                completion(imgCash, duration)
            } else {
                completion(imgCash, nil)
            }
            
            return
        }

        let height = wDevice / 3
        let size = CGSize(width: height, height: height)

        DispatchQueue.global(qos: .userInitiated).async {
            
            let obj = self.fetchResult.object(at: indexPath.row)
            
            self.imgManager.requestImage(for: obj,
                                    targetSize: size,
                                    contentMode: .aspectFill,
                                    options: self.requestImageOption) { (image, _) in
                                        if let img = image {


                                            self.imageCache.setObject(img, forKey: key)
                                            var duration: String?

                                            if obj.mediaType == .video {
                                                duration = obj.duration.durationString as String
                                                self.durationCache.setObject(duration! as NSString, forKey: keyDuration)
                                                
                                            }

                                            DispatchQueue.main.async {
                                                completion(img, duration)
                                            }
                                        }
            }
        }
    }


    func clearCashe() {
       self.imageCache.removeAllObjects()
       self.durationCache.removeAllObjects()
    }

}

extension TimeInterval{
    
    var durationString: String{
        
        let (h,m,s) = Int(self).secondsToHoursMinutesSeconds
        
        let strH = h > 9 ? "\(h)" : "0\(h)"
        
        
        let strM = m > 9 ? "\(m)" : "0\(m)"
        let strS = s > 9 ? "\(s) ": "0\(s)"
        
        if h == 0 {
            return "\(strM):\(strS)"
        }
        
        return "\(strH):\(strM):\(strS)"
    }
   
}

extension Int {
    var secondsToHoursMinutesSeconds: (Int, Int, Int) {
        return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
    }
}

extension IndexPath {

    var keyCashIndex: NSString {
        return "Это_ключ_кэш_памяти_\(self.section)-\(self.row)" as NSString
    }
    
    var keyCashIndexDuration: NSString {
        return "Это_ключ_кэш_памяти_длительности_\(self.section)-\(self.row)" as NSString
    }

}

