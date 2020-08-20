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
    
    var indexBigPhoto: IndexPath? = nil
    private var bigRequest: PHImageRequestID? = nil
    private let size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)

    private let imgManager = PHImageManager.default()

    private var option: PHFetchOptions {
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOption.predicate = NSPredicate(format: "mediaType == %d || mediaType == %d", PHAssetMediaType.image.rawValue,
                                                                                          PHAssetMediaType.video.rawValue)
        
        return fetchOption
    }

    var fetchResult: PHFetchResult<PHAsset> {
        return PHAsset.fetchAssets(with: option)
    }

    var requestOption: PHImageRequestOptions{
        let requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
        requestOption.deliveryMode = .highQualityFormat

        return requestOption
    }
    



    func getImageBig(indexPath: IndexPath, completion: @escaping (UIImage) -> Void){
        
        if let loadIndex = indexBigPhoto{ //защита от повторного тапа
            
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
            let obj = self.fetchResult.object(at: indexPath.row)
            
            if obj.mediaType == .video {
                //получение видео
                
                
                
            } else {
                //получение изображения
                
                self.bigRequest = self.imgManager.requestImage(for: obj,
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
                                    options: self.requestOption) { (image, _) in
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

