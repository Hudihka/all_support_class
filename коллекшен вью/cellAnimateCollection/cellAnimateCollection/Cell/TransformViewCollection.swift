//
//  TransformViewCollection.swift
//  cellAnimateCollection
//
//  Created by Hudihka on 06/04/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class TransformViewCollection: UIView {

	@IBOutlet var conteinerView: UIView!
	
    @IBOutlet weak var imageContent: UIImageView!
	@IBOutlet weak var laelName: UILabel!
	
	convenience init(rect: CGRect, imageName: String) {
		self.init(frameCustom: rect)
		
		self.desingContent(imageName: imageName)
		
	}
	
    
    init(frameCustom: CGRect) {
        super.init(frame: frameCustom)
        xibSetup()
        settingsView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        settingsView()
    }
    
    private func xibSetup() {
        conteinerView = loadViewFromNib("TransformViewCollection")
        conteinerView.frame = bounds
        conteinerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(conteinerView)
    }

    private func settingsView() {
		
		self.conteinerView.addRadius(number: 15)
    }

	
	func desingContent(imageName: String){
		
		self.imageContent.image = UIImage(named: imageName)
		self.laelName.text = imageName
		
	}

}
