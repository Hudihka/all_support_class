

import Foundation
import Firebase

class ScaledElementProcessor {
	
	let vision = Vision.vision()
	var textRecognizer: VisionTextRecognizer!
	  
	init() {
	  textRecognizer = vision.onDeviceTextRecognizer()
	}
	
	func process(in imageView: UIImageView, callback: @escaping (_ text: String) -> Void) {
	  // 1
	  guard let image = imageView.image else { return }
		
	  // В ML Kit используется специальный VisionImageтип. Это полезно, потому что может содержать определенные метаданные для ML Kit для обработки изображения, такие как ориентация изображения
	  let visionImage = VisionImage(image: image)
	  // 3
	  textRecognizer.process(visionImage) { result, error in
		// У класса textRecognizerесть processметод, который принимает VisionImageи возвращает массив текстовых результатов в виде параметра, переданного в закрытие.
		
		guard error == nil, let result = result, !result.text.isEmpty else {
			callback("")
			return
		}
		
		
		callback(result.text)
	  }
	}
}
