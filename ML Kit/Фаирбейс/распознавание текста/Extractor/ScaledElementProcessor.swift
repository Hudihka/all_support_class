

import Foundation
import Firebase

class ScaledElementProcessor {
	
	let vision = Vision.vision()
	var textRecognizer: VisionTextRecognizer!
	  
	init() {
	//если используешь распознавание текста ТОЛЬКО на англ языке
//	  textRecognizer = vision.onDeviceTextRecognizer()
	
		//если используешь распознавание текста кроме как на англ языке
		let options = VisionCloudTextRecognizerOptions()
		options.languageHints = ["en"]//список языков
		textRecognizer = vision.cloudTextRecognizer(options: options)
	}
	
	func process(in imageView: UIImageView,
				 callback: @escaping (_ text: String, _ scaledElements: [ScaledElement]) -> Void) {
	  // 1
	  guard let image = imageView.image else { return }
		
	  // В ML Kit используется специальный VisionImageтип. Это полезно, потому что может содержать определенные метаданные для ML Kit для обработки изображения, такие как ориентация изображения
	  let visionImage = VisionImage(image: image)
	  // 3
	  textRecognizer.process(visionImage) { result, error in
		// У класса textRecognizerесть processметод, который принимает VisionImageи возвращает массив текстовых результатов в виде параметра, переданного в закрытие.
		
		guard error == nil, let result = result, !result.text.isEmpty else {
			//если ты хочешьь распознавать текс кроме как на англ то читай ошибки
			//придется настраивать платежную инф
			callback("", [])
			return
		}
		
		var scaledElements: [ScaledElement] = [] //массив фреймов
		// 3
		for block in result.blocks { //получем блоки результата
		  for line in block.lines {  //получаем линии текста
			for element in line.elements { //получаем элементы
				
			let frame = self.createScaledFrame( //переделываем фрейм
				   featureFrame: element.frame,
				   imageSize: image.size,
				   viewFrame: imageView.frame)
				
			  // создаем структуру
			  let shapeLayer = self.createShapeLayer(frame:frame)
			  let scaledElement = ScaledElement(frame: frame, shapeLayer: shapeLayer)

			  // добавляем структуру в массив
			  scaledElements.append(scaledElement)
			}
		  }
		}
		
		
		callback(result.text, scaledElements)
	  }
	}
	
	
	private func createShapeLayer(frame: CGRect) -> CAShapeLayer {
	  // создаем ободок вокруг фрейма
	  let bpath = UIBezierPath(rect: frame)
	  let shapeLayer = CAShapeLayer()
	  shapeLayer.path = bpath.cgPath
	  // 2
	  shapeLayer.strokeColor = Constants.lineColor
	  shapeLayer.fillColor = Constants.fillColor
	  shapeLayer.lineWidth = Constants.lineWidth
	  return shapeLayer
	}

	// MARK: - private
	  
	// 3
	private enum Constants {
	  static let lineWidth: CGFloat = 3.0
	  static let lineColor = UIColor.yellow.cgColor
	  static let fillColor = UIColor.clear.cgColor
	}

	//размер изображения что поппадает в ml kit соответствует реальному изображению фото
	//имагеВью же сжимается соответствуя верстке, поэтому нужен преобразователь
	
	//Этот метод принимает CGRectисходный размер изображения, размер отображаемого изображения и рамку файла UIImageView.
	
	private func createScaledFrame(featureFrame: CGRect, imageSize: CGSize, viewFrame: CGRect) -> CGRect {
	  let viewSize = viewFrame.size
		
	  // Разрешение изображения и вида рассчитывается путем деления их высоты и ширины соответственно.
	  let resolutionView = viewSize.width / viewSize.height
	  let resolutionImage = imageSize.width / imageSize.height
		
	  // Масштаб определяется тем, какое разрешение больше. Если вид больше, вы масштабируетесь по высоте; в противном случае вы масштабируете по ширине.
	  var scale: CGFloat
	  if resolutionView > resolutionImage {
		scale = viewSize.height / imageSize.height
	  } else {
		scale = viewSize.width / imageSize.width
	  }
		
	  // Этот метод вычисляет ширину и высоту. Ширина и высота рамки умножаются на масштаб, чтобы вычислить масштабированные ширину и высоту.
	  let featureWidthScaled = featureFrame.size.width * scale
	  let featureHeightScaled = featureFrame.size.height * scale
		
	  // Начальная точка кадра также должна быть масштабирована; в противном случае, даже если размер правильный, он будет далеко не по центру в неправильном положении.
	  let imageWidthScaled = imageSize.width * scale
	  let imageHeightScaled = imageSize.height * scale
	  let imagePointXScaled = (viewSize.width - imageWidthScaled) / 2
	  let imagePointYScaled = (viewSize.height - imageHeightScaled) / 2
		
	  // Новое начало координат вычисляется путем добавления шкалы точек x и y к немасштабированной исходной точке, умноженной на масштаб.м
	  let featurePointXScaled = imagePointXScaled + featureFrame.origin.x * scale
	  let featurePointYScaled = imagePointYScaled + featureFrame.origin.y * scale
		
	  // CGRect Возвращается масштабированный , настроенный с вычисленными исходной точкой и размером.
	  return CGRect(x: featurePointXScaled,
					y: featurePointYScaled,
					width: featureWidthScaled,
					height: featureHeightScaled)
	  }

	
}

//структура для отображения изображения
struct  ScaledElement  {
   let frame: CGRect
  let shapeLayer: CALayer
}
