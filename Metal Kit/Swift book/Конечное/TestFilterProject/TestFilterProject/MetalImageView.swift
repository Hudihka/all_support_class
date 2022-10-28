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
	
	func render(image: CIImage, contex: CIContext, device: MTLDevice) {
		ciContext = contex
		self.device = device
		
		var rect = bounds
		rect.size = drawableSize
		rect = AVMakeRect(aspectRatio: image.extent.size, insideRect: rect)
		let transform = CGAffineTransform(scaleX: rect.size.width/image.extent.size.width,
										  y: rect.size.height/image.extent.size.height)
		let filteredImmage = image.transformed(by: transform)
		
		let x = -rect.origin.x
		let y = -rect.origin.y
		
		commandQueue = device.makeCommandQueue()//создаем очередь с девайса
		
		let buffer = commandQueue!.makeCommandBuffer()//создаем буфер под команды
		mlTexture = currentDrawable!.texture //получаем текстуру вьюшки
		
		let rectView = CGRect(origin: CGPoint(x: x, y: y), size: drawableSize)
		
		//делаем рендер
		ciContext!.render(filteredImmage.oriented(.down), //у метала вьью имеет другую геометрию по этому переворачиваем
						  to: currentDrawable!.texture,
						  commandBuffer: buffer,
						  bounds: rectView,
						  colorSpace: CGColorSpaceCreateDeviceRGB())
		
		buffer?.present(currentDrawable!)//отобрази наш прямоугольник
		buffer?.commit()//запускаемм команду
	}
	
}








