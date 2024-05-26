//
//  UIImage+Nuke.swift
//  UniversalUtilites
//
//  Created by Худышка К on 26.05.2024.
//

import Foundation
import UIKit
import Nuke

public extension UIImageView {
    
    @discardableResult
    func loadImage(url: URL?, placeholder: UIImage? = nil) -> Self {
        self.image = placeholder
        downloadNuke(imageURL: url, completion: nil)
        
        return self
    }
    
    @discardableResult
    func loadImage(urlSting: String?, placeholder: UIImage? = nil) -> Self {
        self.image = placeholder
        downloadNuke(imageURL: urlSting, completion: nil)
        
        return self
    }
    
    @discardableResult
    func loadImage(
        url: URL?,
        placeholder: UIImage? = nil,
        completion: @escaping (UIImage?) -> Void
    ) -> Self {
        self.image = placeholder
        downloadNuke(imageURL: url, completion: completion)
        
        return self
    }
    
    @discardableResult
    func loadImage(
        urlSting: String?,
        placeholder: UIImage? = nil,
        completion: @escaping (UIImage?) -> Void
    ) -> Self {
        self.image = placeholder
        downloadNuke(imageURL: urlSting, completion: completion)
        
        return self
    }
}

private extension UIImageView {
    private func downloadNuke(
        imageURL: URL?,
        completion: ((UIImage?) -> Void)? = nil
    ) {
        ImagePipeline.shared.loadImage(
            with: ImageRequest(url: imageURL)
        ) { [weak self] result in
            
            switch result {
            case .success(let success):
                let successImage = success.image
                
                self?.image = successImage
                completion?(successImage)
            default:
                break
            }
        }
    }
    
    private func downloadNuke(
        imageURL: String?,
        completion: ((UIImage?) -> Void)? = nil
    ) {
        ImagePipeline.shared.loadImage(
            with: ImageRequest(url: URL(string: imageURL ?? ""))
        ) { [weak self] result in
            
            switch result {
            case .success(let success):
                let successImage = success.image
                
                self?.image = successImage
                completion?(successImage)
            default:
                break
            }
        }
    }
}
