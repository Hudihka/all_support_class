//
//  ViewController.swift
//  metal macOS
//
//  Created by Hudihka on 07/01/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
//	статья на которой была взята инф
//	https://medium.com/better-programming/making-your-first-circle-using-metal-shaders-1e5049ec8505
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let metalCircleView = MetalCircleView()
		view.addSubview(metalCircleView)
		
		//constraining to window
		metalCircleView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		metalCircleView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		metalCircleView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		metalCircleView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
	
	override var representedObject: Any? {
		didSet {
			// Update the view, if already loaded.
		}
	}
	
	
}

