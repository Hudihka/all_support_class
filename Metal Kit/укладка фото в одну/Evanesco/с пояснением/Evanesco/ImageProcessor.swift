/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///

import CoreImage
import Vision

class ImageProcessor {
  var frameBuffer: [CIImage] = [] //сохранит исходные захваченные изображения.
  var alignedFrameBuffer: [CIImage] = [] //будет содержать изображения после того, как они будут выровнены.
  var completion: ((CIImage) -> Void)?
  var isProcessingFrames = false

  var frameCount: Int {
    return frameBuffer.count
  }

	func  add (_ frame: CIImage) {
		 if isProcessingFrames {
			 return
		}
		
		frameBuffer.append(frame)
	}
	
	
	func processFrames(completion: ((CIImage) -> Void)?) {

		isProcessingFrames = true
		self.completion = completion
		
		//Удалите первый кадр из буфера кадра и добавьте его в буфер кадра для выровненных изображений. Все остальные кадры будут выровнены по этому.
		
		let firstFrame = frameBuffer.removeFirst()
		alignedFrameBuffer.append(firstFrame)
		
		//Прокрутите каждый кадр в буфере кадров.
		
		for frame in frameBuffer {
			// Используйте фрейм для создания нового запроса Vision для определения простого трансляционного выравнивания.
			//выравнивание с учетом того что телефон во время сьемки держали примерно ровно
			let request = VNTranslationalImageRegistrationRequest(targetedCIImage: frame)

			do {
				// Создайте обработчик запроса последовательности, который будет обрабатывать ваши запросы на выравнивание.
				let sequenceHandler = VNSequenceRequestHandler()
				// Выполните запрос Vision, чтобы выровнять кадр с первым кадром и выявить любые ошибки.
				try sequenceHandler.perform([request], on: firstFrame)
			} catch {
				print(error.localizedDescription)
			}
			// выполняем преобразование каждого кадра
			alignImages(request: request, frame: frame)
		}
		// чистим все
		combineFrames()
	}
	
	func alignImages(request: VNRequest, frame: CIImage) {
		// получаем самый весомый результат при реквесте
		guard let results = request.results as? [VNImageTranslationAlignmentObservation],
			let result = results.first else {
				return
		}
		// Преобразуйте кадр, используя матрицу аффинного преобразования, рассчитанную платформой Vision .
		let alignedFrame = frame.transformed(by: result.alignmentTransform)
		alignedFrameBuffer.append(alignedFrame)
	}
	
	func cleanup(image: CIImage) {
		frameBuffer = []
		alignedFrameBuffer = []
		isProcessingFrames = false
		
		if let completion = completion {
			DispatchQueue.main.async {
				completion(image)
			}
		}
		completion = nil
	}
	
	func combineFrames() {
		// Инициализируйте окончательное изображение первым в выровненном буфере кадра и удалите его в процессе.
		var finalImage = alignedFrameBuffer.removeFirst()
		// создаем металовский фильтр
		let filter = AverageStackingFilter()
		//3
		for (i, image) in alignedFrameBuffer.enumerated() {
			// 4
			filter.inputCurrentStack = finalImage
			filter.inputNewImage = image
			filter.inputStackCount = Double(i + 1)
			// 5
			finalImage = filter.outputImage()!
		}
		// 6
		cleanup(image: finalImage)
	}

}
