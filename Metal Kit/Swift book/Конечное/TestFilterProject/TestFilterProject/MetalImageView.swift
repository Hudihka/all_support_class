//
//  MetalImageView.swift
//  TestFilterProject
//
//  Created by Hudihka on 31/12/2020.
//  Copyright © 2020 Anastasia Sokolan. All rights reserved.
//

import AVFoundation
import MetalKit
import UIKit

class MetalImageView: MTKView{//метал кит вьюшка
	private var mlTexture: MTLTexture? //металовская вюшка отображает изображение с помощю текстур
	private var commandQueue: MTLCommandQueue?//спец очередь на которой работает метал
	
	private var ciContext: CIContext?
	
	
	override init(frame frameRect: CGRect, device: MTLDevice?) {
		super.init(frame: frameRect, device: device)
		
		isOpaque 			  = false //вььюшка не прозрачная
		enableSetNeedsDisplay = true  //мы не хотим анимированно иенятьь изображения
		framebufferOnly 	  = false
	}
	
	required init(coder: NSCoder) {
		super.init(coder: coder)
		
		isOpaque 			  = false //вььюшка не прозрачная
		enableSetNeedsDisplay = true  //мы не хотим анимированно иенятьь изображения
		framebufferOnly 	  = false
	}
}
