//
//  ManagerLibsUserPhoto.swift
//  GinzaGO
//
//  Created by Username on 17.07.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import UIKit
import Photos

class ManagerLibsUserPhoto: NSObject {
    static let shared = ManagerLibsUserPhoto()

    private let imgManager = PHImageManager.default()
    let imageCache = NSCache<NSString, UIImage>()
    private let sizePhoto = CGSize(width: 250, height: 250)

    func reqwestResult() -> PHFetchResult<PHAsset> {
        let fetchOptions = PHFetchOptions()
        let requestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = .exact
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat

        return PHAsset.fetchAssets(with: .image, options: fetchOptions)
    }

    func getImageGalereryAll(index: IndexPath, completion: @escaping (UIImage) -> Void) {
        if let image = getImageGalereryCash(index: index) {
            completion(image)
            return
        } else {
            getImageGalerery(index: index) { (img) in
                completion(img)
                return
            }
        }

        completion(UIImage(named: "placeholder") ?? UIImage())
    }

    func getImageGalerery(index: IndexPath, isSmallSize: Bool = true, completion: @escaping (UIImage) -> Void) {
        let ind = getInd(index)
        let asset = reqwestResult().object(at: ind)

        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()

        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact

        let size = isSmallSize ? self.sizePhoto : PHImageManagerMaximumSize

        DispatchQueue.global(qos: .userInitiated).async {
            manager.requestImage(for: asset,
                                 targetSize: size,
                                 contentMode: .aspectFit,
                                 options: options,
                                 resultHandler: {(result, _) -> Void in
                                    if let result = result {
                                        self.imageCache.setObject(result, forKey: self.uniqueKeyCell(index))
                                        DispatchQueue.main.async {
                                            completion(result)
                                        }
                                    }
            })
        }
    }

    private func getImageGalereryCash(index: IndexPath) -> UIImage? {
        if let img = imageCache.object(forKey: uniqueKeyCell(index)) {
            return img
        }
        return nil
    }

    private func uniqueKeyCell(_ index: IndexPath) -> NSString {
        let strInd = getInd(index)
        return "row_\(strInd)_section_0" as NSString
    }

    private func getInd(_ index: IndexPath) -> Int {
        let ind = (reqwestResult().count - 1) - index.row
        return ind
    }

    func clearCash() {
        imageCache.removeAllObjects()
    }
}
