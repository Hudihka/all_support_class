/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell

import Foundation
import UIKit

enum PhotoRecordState {
  case new, downloaded, filtered, failed
}

class PhotoRecord {
  let name: String
  let url: URL
  var state = PhotoRecordState.new
  var image = UIImage(named: "Placeholder")
  
  init(name:String, url:URL) {
    self.name = name
    self.url = url
  }
}

class PendingOperations {
  lazy var downloadsInProgress: [IndexPath: Operation] = [:]
	
  lazy var downloadQueue: OperationQueue = {
    var queue = OperationQueue()
    queue.name = "Download queue"
    queue.maxConcurrentOperationCount = 1
    return queue
  }()
  
  lazy var filtrationsInProgress: [IndexPath: Operation] = [:]
	
  lazy var filtrationQueue: OperationQueue = {
    var queue = OperationQueue()
    queue.name = "Image Filtration queue"
    queue.maxConcurrentOperationCount = 1
    return queue
  }()
}


class ImageDownloader: Operation {
  //1
  let photoRecord: PhotoRecord
  
  //2
  init(_ photoRecord: PhotoRecord) {
    self.photoRecord = photoRecord
  }
  
  //это метод, который вы переопределяете в Operationподклассах для фактического выполнения работы.
  override func main() {
    //Проверьте отмену перед началом. Перед тем, как приступить
	//к длительной или интенсивной работе, следует
	//регулярно проверять, не были ли они отменены.
    if isCancelled {
      return
    }

    //Загрузите данные изображения.
    guard let imageData = try? Data(contentsOf: photoRecord.url) else { return }
    
    //6
    if isCancelled {
      return
    }
    
    //Если есть данные, создайте объект изображения
	//и добавьте его в запись, а затем переместите состояние.
	//Если данных нет, отметьте запись как неудавшуюся
	//и установите соответствующее изображение.
    if !imageData.isEmpty {
      photoRecord.image = UIImage(data:imageData)
      photoRecord.state = .downloaded
    } else {
      photoRecord.state = .failed
      photoRecord.image = UIImage(named: "Failed")
    }
  }
}


class ImageFiltration: Operation {
  let photoRecord: PhotoRecord
  
  init(_ photoRecord: PhotoRecord) {
    self.photoRecord = photoRecord
  }
  
  override func main () {
    if isCancelled {
        return
    }
      
    guard self.photoRecord.state == .downloaded else {
      return
    }
      
    if let image = photoRecord.image, let filteredImage = applySepiaFilter(image) {
      photoRecord.image = filteredImage
      photoRecord.state = .filtered
    }
  }
	
	func applySepiaFilter(_ image: UIImage) -> UIImage? {
	  guard let data = UIImagePNGRepresentation(image) else { return nil }
	  let inputImage = CIImage(data: data)
		  
	  if isCancelled {
		return nil
	  }
		  
	  let context = CIContext(options: nil)
		  
	  guard let filter = CIFilter(name: "CISepiaTone") else { return nil }
	  filter.setValue(inputImage, forKey: kCIInputImageKey)
	  filter.setValue(0.8, forKey: "inputIntensity")
		  
	  if isCancelled {
		return nil
	  }
		  
	  guard
		let outputImage = filter.outputImage,
		let outImage = context.createCGImage(outputImage, from: outputImage.extent)
	  else {
		return nil
	  }

	  return UIImage(cgImage: outImage)
	}

}


