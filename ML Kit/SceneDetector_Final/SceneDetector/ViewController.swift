

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

  // MARK: - IBOutlets
  @IBOutlet weak var scene: UIImageView!
  @IBOutlet weak var answerLabel: UILabel!

  // MARK: - Properties
  let vowels: [Character] = ["a", "e", "i", "o", "u"] //гласные буквы
	
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    guard let image = UIImage(named: "train_night") else {
      fatalError("no starting image")
    }

    scene.image = image
    
    guard let ciImage = CIImage(image: image) else {
      fatalError("couldn't convert UIImage to CIImage")
    }

    detectScene(image: ciImage)
  }

// MARK: - IBActions

  @IBAction func pickImage(_ sender: Any) {
    let pickerController = UIImagePickerController()
    pickerController.delegate = self
    pickerController.sourceType = .savedPhotosAlbum
    present(pickerController, animated: true)
  }

// MARK: - Methods
	
	

  func detectScene(image: CIImage) {
		
    answerLabel.text = "detecting scene..." //говорим лейблу что ведем работу
		
		//получаем модель
    guard let model = try? VNCoreMLModel(for: GoogLeNetPlaces().model) else {
      fatalError("can't load Places ML model")
    }

    // Create a Vision request with completion handler
		
		//создаем реквест в вижен, используя модель обучения
    let request = VNCoreMLRequest(model: model) { [weak self] request, error in
      guard let results = request.results as? [VNClassificationObservation],
        let topResult = results.first else { //берем первый тк у него наибольший процент
          fatalError("unexpected result type from VNCoreMLRequest")
      }

      //проверяем первая буква обььекта глассная или согласная
      let article = (self?.vowels.contains(topResult.identifier.first!))! ? "an" : "a"
			
      DispatchQueue.main.async { [weak self] in
				//пишем на лейбле что за обььект
        self?.answerLabel.text = "\(Int(topResult.confidence * 100))% it's \(article) \(topResult.identifier)"
      }
    }

    // Run the Core ML GoogLeNetPlaces classifier on global dispatch queue
    let handler = VNImageRequestHandler(ciImage: image) //что бы сделать реквест необходим обьект VNImageRequestHandler получаем его через изображение
		
    DispatchQueue.global(qos: .userInteractive).async {
      do {
        try handler.perform([request])
      } catch {
        print(error)
      }
    }
  }
}

// MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    dismiss(animated: true)
    guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
      fatalError("couldn't load image from Photos")
    }

    scene.image = image
    
    guard let ciImage = CIImage(image: image) else {
      fatalError("couldn't convert UIImage to CIImage")
    }

    detectScene(image: ciImage)
  }
}

// MARK: - UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {
}
