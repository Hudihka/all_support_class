//
//  ManagerLibsUserPhoto.swift
//  Photi Lirary
//
//  Created by Hudihka on 19/07/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit
import Photos

class ManagerLibsUserPhoto: NSObject {
    static let shared = ManagerLibsUserPhoto()

    private let imgManager = PHImageManager.default()
    let imageCache = NSCache<NSString, UIImage>()

    private func reqwestOptions() -> PHImageRequestOptions {
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat

        return requestOptions
    }

    func reqwestResult() -> PHFetchResult<PHAsset> {
        let fetchOptions = PHFetchOptions()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat

        return PHAsset.fetchAssets(with: .image, options: fetchOptions)
    }

    func getImage(index: IndexPath, completion: @escaping (UIImage?) -> Void) {
        let ind = index.row
        let key = uniqueKeyCell(index) as NSString

        if let img = imageCache.object(forKey: key) {
            completion(img)
        } else if ind < reqwestResult().count {
            DispatchQueue.global(qos: .background).async {
                self.imgManager.requestImage(for: self.reqwestResult().object(at: ind) as PHAsset,
                                             targetSize: CGSize(width: 500, height: 500),
                                             contentMode: .aspectFill,
                                             options: self.reqwestOptions(),
                                             resultHandler: { (image, _) in
                                                DispatchQueue.main.async {
                                                    if let img = image {
                                                        self.imageCache.setObject(img, forKey: key)
                                                        completion(img)
                                                    }
                                                }
                })
            }
        }
    }

    private func uniqueKeyCell(_ index: IndexPath) -> String {
        return "row_\(index.row)_section\(index.section)"
    }

    func clearCash() {
        imageCache.removeAllObjects()
    }
}
