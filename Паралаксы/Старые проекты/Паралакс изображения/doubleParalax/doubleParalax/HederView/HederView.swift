//
//  HederView.swift
//  doubleParalax
//
//  Created by Hudihka on 18/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import Foundation
import UIKit

class HederView: UIView{
    
    @IBOutlet weak var conteinerView: UIView!

    @IBOutlet private var horizontalConstreints: [NSLayoutConstraint]!
    @IBOutlet private weak var downConstrein: NSLayoutConstraint!
    @IBOutlet private weak var upConstreint: NSLayoutConstraint!
    
    private var downParalaxArray = [NSLayoutConstraint]()
    
    @IBOutlet weak var imageContent: UIImageView!
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        settingsView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        settingsView()
    }
    
    private func xibSetup() {
        conteinerView = loadViewFromNib("HederView")
        conteinerView.frame = bounds
        conteinerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(conteinerView)
    }

    private func settingsView() {
        self.downParalaxArray += horizontalConstreints
        self.downParalaxArray.append(upConstreint)
    }
    
    
    func paralax(scrollView: UIScrollView) {
        let delta: CGFloat = scrollView.contentOffset.y
        
        addSettings(deltaNegative: delta < 0)
        if delta < 0 {
            swipeDownParalax(delta: delta)
        } else if delta > 0{
            swipeUpParalax(delta: delta / 2)
        } else { //== 0
            
        }
        
    }
    
    
    private func swipeDownParalax(delta: CGFloat){
        
        for obj in downParalaxArray {
            obj.constant = delta
        }
    }
    
    private func swipeUpParalax(delta: CGFloat){
        
        upConstreint.constant = delta
        downConstrein.constant = -1 * delta
        
    }
    
    private func addSettings(deltaNegative: Bool){
        if deltaNegative, clipsToBounds{
            clipsToBounds = false
        } else if !clipsToBounds, !deltaNegative{
            clipsToBounds = true
        }
    }


    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
