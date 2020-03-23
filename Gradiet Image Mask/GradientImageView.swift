//
//  GradientImageView.swift
//  ChefMarket_2.0
//
//  Created by Александр Нейфельд on 17.05.2018.
//  Copyright © 2018 itMegaStar. All rights reserved.
//

import UIKit

class GradientImageView: UIImageView {

    
    var gradientView: GradientView?
    var topGradientView: GradientView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        gradientView = GradientView(frame: bounds)
        topGradientView = GradientView(frame: bounds)
        
        let gradient = gradientView?.layer
        let topGradient = topGradientView?.layer
        
        gradient?.colors = [
            UIColor.clear.cgColor,
            UIColor(red:0.16, green:0.16, blue:0.16, alpha:0.9).cgColor
        ]
        gradient?.locations = [0, 1]
        gradient?.startPoint = CGPoint(x: 0.5, y: 0)
        gradient?.endPoint = CGPoint(x: 0.5, y: 1)
        
        self.addSubview(gradientView!)
        
        topGradient?.colors = [
            UIColor.clear.cgColor,
            UIColor(red:0.16, green:0.16, blue:0.16, alpha:0.9).cgColor
        ]
        topGradient?.locations = [0, 1]
        topGradient?.startPoint = CGPoint(x: 0.5, y: 1)
        topGradient?.endPoint = CGPoint(x: 0.5, y: 0)
        
        
        self.addSubview(topGradientView!)
    }
    
    override func layoutSubviews() {
        
        var frame = self.frame
        frame.size.height = self.frame.size.height / 2
        frame.origin.y = self.frame.size.height / 2
        
        gradientView?.frame = frame
        
        var topFrame = self.frame
        topFrame.size.height = self.frame.size.height / 3
        topFrame.origin.y = 0
        
        topGradientView?.frame = topFrame
    }

}
