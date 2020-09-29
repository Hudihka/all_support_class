//
//  ZoomView.swift
//  testCollectionView
//
//  Created by Админ on 03.08.2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import Foundation
import UIKit

class ZoomView: UIScrollView, UIScrollViewDelegate {
	
	var tapedClearNavigationBar: () -> () = {  }

    private var imageZoomView: UIImageView!
    
    private lazy var zoomingDoubleTap: UITapGestureRecognizer = {
        let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingDoubleTap))
        zoomingTap.numberOfTapsRequired = 2
        return zoomingTap
    }()
	
	private lazy var tapGesters: UITapGestureRecognizer = {
        let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        zoomingTap.numberOfTapsRequired = 1
        return zoomingTap
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.decelerationRate = UIScrollView.DecelerationRate.fast
		self.backgroundColor = .clear
		
		self.maximumZoomScale = 3
		self.minimumZoomScale = 1
		self.zoomScale = self.minimumZoomScale
		self.contentSize = self.frame.size
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	func set(image: UIImage) {
		
		imageZoomView?.removeFromSuperview()
		imageZoomView = nil
		imageZoomView = UIImageView(frame: CGRect(origin: .zero, size: self.frame.size))
		imageZoomView.image = image
		imageZoomView.contentMode = .scaleAspectFit
		addSubview(imageZoomView)
		
		
		imageZoomView.addGestureRecognizer(self.zoomingDoubleTap)
		imageZoomView.addGestureRecognizer(self.tapGesters)
		
		imageZoomView.isUserInteractionEnabled = true
		
		tapGesters.require(toFail: zoomingDoubleTap)
		
	}
    
    // gesture
	
	@objc func handleZoomingDoubleTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        self.zoom(point: location, animated: true)
    }
	
    @objc func handleTap(sender: UITapGestureRecognizer) {
		tapedClearNavigationBar()
    }
	
    
    private func zoom(point: CGPoint, animated: Bool) {
        let currectScale = self.zoomScale
        let minScale = self.minimumZoomScale
        let maxScale = self.maximumZoomScale
        
        if (minScale == maxScale && minScale > 1) {
            return
        }
        
        let toScale = maxScale
        let finalScale = (currectScale == minScale) ? toScale : minScale
        let zoomRect = self.zoomRect(scale: finalScale, center: point)
        self.zoom(to: zoomRect, animated: animated)
    }
    
    
    private func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        let bounds = self.bounds
        
        zoomRect.size.width = bounds.size.width / scale
        zoomRect.size.height = bounds.size.height / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        return zoomRect
    }
    
    // MARK: - UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageZoomView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = imageZoomView.image {
                let ratioW = imageZoomView.frame.width / image.size.width
                let ratioH = imageZoomView.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth*scrollView.zoomScale > imageZoomView.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - imageZoomView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditioTop = newHeight*scrollView.zoomScale > imageZoomView.frame.height
                
                let top = 0.5 * (conditioTop ? newHeight - imageZoomView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
    
}
