//
//  UIView.swift
//  YouTubeCollection
//
//  Created by Hudihka on 13/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import Foundation
import UIKit

enum DimensionsEnum {
    static let hDdevice = UIScreen.main.bounds.size.height
    static let wDdevice = UIScreen.main.bounds.size.width
}

extension UIView {
    @objc func loadViewFromNib(_ name: String) -> UIView { //добавление вью созданной в ксиб файле
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            return view
        } else {
            return UIView()
        }
    }
}

extension UICollectionView{
    
    func frameCell(_ selectedIndex: IndexPath) -> CGRect {

           if let attributes: UICollectionViewLayoutAttributes = self.layoutAttributesForItem(at: selectedIndex) {
               let rect = attributes.frame
               let cellFrameInSuperview = self.convert(rect, to: self.superview)

               return cellFrameInSuperview

           }

           return CGRect()

       }
}
