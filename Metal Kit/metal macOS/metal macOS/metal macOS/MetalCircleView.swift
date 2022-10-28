//
//  MetalCircleView.swift
//  metal macOS
//
//  Created by Hudihka on 07/01/2021.
//  Copyright © 2021 OOO MegaStar. All rights reserved.
//

import Cocoa
import MetalKit
import simd//фреймворк для метал отрисовки, для векторов

class MetalCircleView: NSView {
	
	private var metalView : MTKView!
	private var metalDevice : MTLDevice!
	private var metalCommandQueue : MTLCommandQueue!
	/*
	MTLRenderPipelineState объект, который определяет состояние графики, включая функции вершинного и фрагментного шейдера , перед выполнением любых вызовов рисования.
	*/
	private var metalRenderPipelineState : MTLRenderPipelineState!
	
	// MARK: VERTEX VARS
    var circleVertices = [simd_float2]()
	private var vertexBuffer: MTLBuffer!
	
	public required init(){
		super.init(frame: .zero)
		setupView()
		createVertexPoints()
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
        metalDevice = MTLCreateSystemDefaultDevice()!
        metalView.device = metalDevice
		
		metalCommandQueue = metalDevice.makeCommandQueue()!
		
		// создание состояния конвейера рендеринга
        createPipelineState()
		
		// превращаем точки вершин в данные буфера
		/*
		создает MTLBufferобъект путем копирования данных из существующего распределения памяти в новое распределение.
		
		makeBufferФункция принимает «длину» число байтов из наших circleVertices и сохраняет его в GPU / CPU доступной памяти. Для длины мы получаем шаг (количество байтов от начала одного экземпляра Tдо начала следующего при хранении в непрерывной памяти или в файлеArray<T> ) из MemoryLayout типа данных (в нашем случае simd_float2) и умножьте его на количество записей этого типа в массиве.
		*/
        vertexBuffer = metalDevice.makeBuffer(bytes: circleVertices, length: circleVertices.count * MemoryLayout<simd_float2>.stride, options: [])!
        
        
        // рисуем
//        metalView.needDisplay = true
    }
	
	fileprivate  func  createPipelineState() {
//		Чтобы создать состояние конвейера, нам понадобится файл
		let pipelineDescriptor = MTLRenderPipelineDescriptor()
		
		// находит металлический файл из основного пакета
		let library = metalDevice.makeDefaultLibrary()!
		
		// передаем имена функции в pipelineDescriptor
		pipelineDescriptor.vertexFunction = library.makeFunction(name: "vertexShader")
		pipelineDescriptor.fragmentFunction = library.makeFunction(name: "fragmentShader")
		
		// устанавливаем формат пикселей в соответствии с форматом пикселей MetalView
		pipelineDescriptor.colorAttachments[0].pixelFormat = metalView.colorPixelFormat
		
		// создаем состояние конвейера, используя интерфейс gpu и pipelineDescriptor
		metalRenderPipelineState = try! metalDevice.makeRenderPipelineState(descriptor: pipelineDescriptor)
		
	}
	
	fileprivate func createVertexPoints(){
        func rads(forDegree d: Float)->Float32{
            return (Float.pi*d)/180
        }
		
		let origin = simd_float2(0, 0)
		
		for i in 0...720 {
			let position : simd_float2 = [cos(rads(forDegree: Float(Float(i)/2.0))), sin(rads(forDegree: Float(Float(i)/2.0)))]
			circleVertices.append(position)
			
			if (i+1)%2 == 0 {
				circleVertices.append(origin)
			}
		}
        
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

		// Мы говорим, какой конвейер рендеринга использовать
		renderEncoder.setRenderPipelineState(metalRenderPipelineState)
		
		/*Это то, что запускает нашу функцию vertexShader. Все, что мы сделали до сих пор, сделано на данный момент. Мы говорим нашему кодировщику рендеринга нарисовать конкретный примитив (помните, когда мы перебирали MTLPrimitiveTypes), с какой вершины начинать и vertexCount.
		
		Вам может быть интересно, зачем нам указывать точку vertexStart и точку vertexCount. Это необходимо, когда вы хотите создать разные типы примитивов в одном проходе рендеринга. Если ваши первые 1000 вершин предназначены для треугольников, а следующие 1000 - для линий, вам нужно указать, с какой вершины начинается следующий тип примитива.*/
		
		renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
		renderEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 1081)
        
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
