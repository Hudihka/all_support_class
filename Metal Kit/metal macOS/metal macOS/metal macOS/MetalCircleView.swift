//
//  MetalCircleView.swift
//  metal macOS
//
//  Created by Hudihka on 07/01/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import Cocoa
import MetalKit

class MetalCircleView: NSView {
	
	private var metalView : MTKView!
	
	public required init(){
		super.init(frame: .zero)
		setupView()
        setupMetal()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError()
	}
	
	fileprivate func setupView(){
		translatesAutoresizingMaskIntoConstraints = false
	}
	
    fileprivate func setupMetal(){
        //view
        metalView = MTKView()
        addSubview(metalView)
        metalView.translatesAutoresizingMaskIntoConstraints = false
        metalView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        metalView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        metalView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        metalView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        metalView.delegate = self
    }
	
}

extension MetalCircleView : MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        //not worried about this
    }
    
    func draw(in view: MTKView) {
        //this is where we do all our drawing
    }
}
