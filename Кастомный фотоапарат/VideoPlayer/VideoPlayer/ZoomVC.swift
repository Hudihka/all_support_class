//
//  ZoomViewController.swift
//  testCollectionView
//
//  Created by Админ on 03.08.2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import Foundation
import UIKit

class ZoomViewController: UIViewController {
    
    private lazy var zoomingTap: UITapGestureRecognizer = {
        let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
        zoomingTap.numberOfTapsRequired = 2
        return zoomingTap
    }()
    
    var blockNewImage: (UIImage) -> () = { _ in }

    @IBOutlet weak var downConstreint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    private var imageZoom: UIImage?
    
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    @IBOutlet weak var cupView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        downConstreint.constant = isIPhoneXorXmax ? 0 : 20

        if let imageZoom = imageZoom {
            imageView.image = imageZoom
        }
        
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 1
        
        scrollView.delegate = self
        
        let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
        zoomingTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(zoomingTap)
        

        addButtons()

    }

    
//    static func route(image: UIImage) -> ZoomViewController{
//        let VC = EnumStoryboard.photo.vc("ZoomViewController") as! ZoomViewController
//        VC.imageZoom = image
//        return VC
//    }
    

    private func addButtons(){
        
        let yGrey: CGFloat = isIPhoneXorXmax ? 52 : 30
        let xGrey: CGFloat = wDevice - 42
        let greyRect = CGRect(x: xGrey,
                              y: yGrey,
                               width: 28,
                               height: 28)
        let crossButton = UIButton(frame: greyRect)
        crossButton.setImage(UIImage(named: "exitBlackBold"), for: .normal)
        crossButton.addTarget(self, action: #selector(dismiss(sender:)), for: .touchUpInside)
        
        self.view.addSubview(crossButton)
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        spiner.startAnimating()
        scrollView.isScrollEnabled = false
        
        let imageSV = scrollView.screenshot
        cupView.image = imageSV
        let newAvatar = cupView.screenshot

        blockNewImage(newAvatar)

        spiner.stopAnimating()
        
        self.dismiss(animated: true, completion: nil)
    }
    

    
    @objc private func dismiss(sender: Any) {
        
        
    }
    
    
    //MARK: gesture
    @objc func handleZoomingTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        self.zoom(point: location, animated: true)
    }
    
    private func zoom(point: CGPoint, animated: Bool) {
        let currectScale = self.scrollView.zoomScale
        let minScale = self.scrollView.minimumZoomScale
        let maxScale = self.scrollView.maximumZoomScale
        
        if (minScale == maxScale && minScale > 1) {
            return
        }
        
        let toScale = maxScale
        let finalScale = (currectScale == minScale) ? toScale : minScale
        let zoomRect = self.zoomRect(scale: finalScale, center: point)
        self.scrollView.zoom(to: zoomRect, animated: animated)
    }
    
    private func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        let bounds = self.scrollView.bounds
        
        zoomRect.size.width = bounds.size.width / scale
        zoomRect.size.height = bounds.size.height / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        return zoomRect
    }
    
}


extension ZoomViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = imageView.image {
                let ratioW = imageView.frame.width / image.size.width
                let ratioH = imageView.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth*scrollView.zoomScale > imageView.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - imageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditioTop = newHeight*scrollView.zoomScale > imageView.frame.height
                
                let top = 0.5 * (conditioTop ? newHeight - imageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}
