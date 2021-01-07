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
	private var metalDevice : MTLDevice!
	private var metalCommandQueue : MTLCommandQueue!
	
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
		
		/*
			включить отображение его набора с помощью
		*/
        metalView.isPaused = true
		/*
		Это говорит ему, что он должен быть приостановлен и должен ждать, пока мы не сообщим ему, когда ему нужно что-то отобразить.
		*/
        metalView.enableSetNeedsDisplay = true
        
        //connect to the gpu
        metalDevice = MTLCreateSystemDefaultDevice()
        metalView.device = metalDevice
		
		metalCommandQueue = metalDevice.makeCommandQueue()!
    }
	
}

extension MetalCircleView : MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        //not worried about this
    }
    
    func draw(in view: MTKView) {
		//буфер для выполнения команд
        guard let commandBuffer = metalCommandQueue.makeCommandBuffer() else {return}
		
		//Создание интерфейса для конвейера
		//получаем информацию о вью
        guard let renderDescriptor = view.currentRenderPassDescriptor else {return}
		
        //Установка "цвета фона"
        renderDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 0, 1, 1)
		
		//Создание командного кодировщика или «внутри» конвейера
        guard let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderDescriptor) else {return}
        
		//Завершите кодирование.
		renderEncoder.endEncoding()
		/*Сообщите графическому процессору, куда отправить результат рендеринга.
		MTLDrawable- это « отображаемый ресурс, который можно отображать или записывать. ”
		*/
		commandBuffer.present(view.currentDrawable!)
		//Добавляем инструкцию в нашу metalCommandQueue
		commandBuffer.commit()
    }
}
