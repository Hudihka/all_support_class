

import Foundation
import CoreImage

class AverageStackingFilter: CIFilter {
  let kernel: CIBlendKernel
	
  var inputCurrentStack: CIImage?
  var inputNewImage: CIImage?
  var inputStackCount = 1.0
	
	override init() {
		// 1
		guard let url = Bundle.main.url(forResource: "default", withExtension: "metallib") else {
			fatalError("Check your build settings.")
		}
		
		
		do {
			// Прочтите содержимое файла.
			let data = try Data(contentsOf: url)
			// Попробуйте создать функцию CIBlendKernelиз avgStackingфайла Metal
			kernel = try CIBlendKernel(
				functionName: "avgStacking",
				fromMetalLibraryData: data)
		} catch {
			print(error.localizedDescription)
			fatalError("Make sure the function names match")
		}
		// 4
		super.init()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	/*
	Этот метод очень важен. А именно, он применит вашу функцию ядра к входным изображениям и вернет выходное изображение! Если бы он этого не делал, это был бы бесполезный фильтр.
	*/
	
	func outputImage() -> CIImage? {
		guard let inputCurrentStack = inputCurrentStack, let inputNewImage = inputNewImage else {
				return nil
		}
		return kernel.apply(extent: inputCurrentStack.extent, arguments: [inputCurrentStack, inputNewImage, inputStackCount])
	}
}
