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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage) {
        
        imageZoomView?.removeFromSuperview()
        imageZoomView = nil
        imageZoomView = UIImageView(image: image)
        self.addSubview(imageZoomView)
        
        configurateFor(imageSize: image.size)
    }
    
    func configurateFor(imageSize: CGSize) {
        self.contentSize = imageSize
        
        setCurrentMaxandMinZoomScale()
        self.zoomScale = self.minimumZoomScale
        
        self.imageZoomView.addGestureRecognizer(self.zoomingDoubleTap)
		self.imageZoomView.addGestureRecognizer(self.tapGesters)
		tapGesters.require(toFail: zoomingDoubleTap)
        self.imageZoomView.isUserInteractionEnabled = true

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.centerImage()
    }
    
    private func setCurrentMaxandMinZoomScale() {
        let boundsSize = self.bounds.size
        let imageSize = imageZoomView.bounds.size
        
        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        let minScale = min(xScale, yScale)
        
        self.minimumZoomScale = minScale
		self.maximumZoomScale = minScale * 3
    }
    
    private func centerImage() {
        let boundsSize = self.bounds.size
        var frameToCenter = imageZoomView.frame
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = -40
        }
        
        imageZoomView.frame = frameToCenter
    }
    
    // gesture
    @objc private func handleZoomingDoubleTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        self.zoom(point: location, animated: true)
    }
	
		@objc private func handleTap(sender: UITapGestureRecognizer) {
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
        return self.imageZoomView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerImage()
    }
    
	
	
}
