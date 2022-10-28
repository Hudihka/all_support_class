///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import AVFoundation
import UIKit

class CameraViewController: UIViewController {
  @IBOutlet var previewView: UIView!
  @IBOutlet var containerView: UIView!
  @IBOutlet var combinedImageView: UIImageView!
  @IBOutlet var recordButton: RecordButton!
	
  var previewLayer: AVCaptureVideoPreviewLayer!
  let session = AVCaptureSession()
  var isRecording = false
  let maxFrameCount = 20
	
	var saver: ImageSaver? //сохранение изображения
	let imageProcessor = ImageProcessor()


  override func viewDidLoad() {
    super.viewDidLoad()
    containerView.isHidden = true
    configureCaptureSession()
    session.startRunning()
  }
}

// MARK: - Configuration Methods

extension CameraViewController {
  func configureCaptureSession() {
    guard let camera = AVCaptureDevice.default(for: .video) else {
      fatalError("No video camera available")
    }
    do {
      let cameraInput = try AVCaptureDeviceInput(device: camera)
      session.addInput(cameraInput)
      try camera.lockForConfiguration()
			// максимальную частоту кадров в пять кадров в секунду
      camera.activeVideoMinFrameDuration = CMTime(value: 1, timescale: 5)
			// одинаковую минимальную частоту кадров
      camera.activeVideoMaxFrameDuration = CMTime(value: 1, timescale: 5)
      camera.unlockForConfiguration()
    } catch {
      fatalError(error.localizedDescription)
    }

		let videoOutput = AVCaptureVideoDataOutput()
    videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "video data queue"))
    videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
    session.addOutput(videoOutput)
    let videoConnection = videoOutput.connection(with: .video)
    videoConnection?.videoOrientation = .portrait
    previewLayer = AVCaptureVideoPreviewLayer(session: session)
    previewLayer.videoGravity = .resizeAspectFill
    previewLayer.frame = view.bounds
    previewView.layer.addSublayer(previewLayer)
  }
}

// MARK: - UI Methods

extension CameraViewController {
	
  @IBAction func recordTapped(_ sender: UIButton) { //запись
    recordButton.isEnabled = false
    isRecording = true
		
		saver = ImageSaver()
  }
  
  @IBAction func closeButtonTapped(_ sender: UIButton) {
    containerView.isHidden = true
    recordButton.isEnabled = true
    session.startRunning()
  }

  func stopRecording() {
    isRecording = false
    recordButton.progress = 0.0
  }
  
  func displayCombinedImage(_ image: CIImage) {
    session.stopRunning()
    combinedImageView.image = UIImage(ciImage: image)
    containerView.isHidden = false
  }
}

// MARK: - Capture Video Data Delegate Methods

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    if !isRecording {
      return
    }
		
		//Извлеките CVImageBufferиз захваченного буфера выборки и преобразуйте его в CGImage.
		guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer),
					//мы делаем преобразование потому что буфер имеет малый обьем памяти, cgImage является копией
				  let cgImage = CIImage(cvImageBuffer: imageBuffer).cgImage() else {
				return
		}
		// Преобразуйте CGImageв CIImage.
		let image = CIImage(cgImage: cgImage)
		// Запишите изображение в каталог документов .
		imageProcessor.add(image)

		saver?.write(image)
		
		
		
    let currentFrame = recordButton.progress * CGFloat(maxFrameCount)
    recordButton.progress = (currentFrame + 1.0) / CGFloat(maxFrameCount)
    if recordButton.progress >= 1.0 {
      stopRecording()
			imageProcessor.processFrames(completion: displayCombinedImage)
    }
  }
}
