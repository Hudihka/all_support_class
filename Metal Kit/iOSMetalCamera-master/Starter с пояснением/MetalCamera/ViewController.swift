//
//  ViewController.swift
//  MetalCamera
//
//  Created by Alex Barbulescu on 2020-05-21.
//  Copyright © 2020 ca.alexs. All rights reserved.
//

import UIKit
import AVFoundation
import MetalKit

class ViewController: UIViewController {
    //MARK:- Vars
    var captureSession : AVCaptureSession!
    
    var backCamera : AVCaptureDevice!
    var frontCamera : AVCaptureDevice!
	
    var backInput : AVCaptureInput!
    var frontInput : AVCaptureInput!
    
    var previewLayer : AVCaptureVideoPreviewLayer!
    
    var videoOutput : AVCaptureVideoDataOutput!
    
    var takePicture = false
    var backCameraOn = true
	
	//проперти  метала
	
	let mtkView = MTKView()
	var metalDevice : MTLDevice!
	/*
	« MTLCommandQueueОбъект используется для постановки упорядоченного списка командных буферов в очередь MTLDeviceдля выполнения».
	*/
	var metalCommandQueue: MTLCommandQueue!
	var ciContext : CIContext!
	var currentCIImage: CIImage? //основное изображение
	
	//филььтры
	
    let fadeFilter = CIFilter(name: "CIPhotoEffectFade")
    let sepiaFilter = CIFilter(name: "CISepiaTone")
    
    //MARK:- View Components
    let switchCameraButton : UIButton = {
        let button = UIButton()
        let image = UIImage(named: "switchcamera")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let captureImageButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let capturedImageView = CapturedImageView()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkPermissions()
		setupMetal()
		setupCoreImage()
        setupAndStartCaptureSession()
    }
	
	//настройка метала
	
    func setupMetal(){
        //получаем графический процессор по умолчанию устройства (только один на устройствах iOS)
        metalDevice = MTLCreateSystemDefaultDevice()
        
        //tell our MTKView which gpu to use
        mtkView.device = metalDevice
		
		// сообщаем нашему MTKView использовать явное рисование, что означает, что мы должны вызвать для него .draw ()
		mtkView.isPaused  =  true //останавливать цикл рисования
		mtkView.enableSetNeedsDisplay  =  false
        
		//создаем очередь команд, чтобы иметь возможность отправлять инструкции на GPU
		metalCommandQueue = metalDevice.makeCommandQueue()

		/*
		у MTKViewнего есть MTKViewDelegateцель, чтобы реагировать на события рисования представления. Именно здесь мы фактически отправляем команды.
		*/
		
		mtkView.delegate = self
		
		// позволяем записать рисованную текстуру в
        mtkView.framebufferOnly = false
    }
	
	// MARK: - Изображение ядра
    func  setupCoreImage () {
        ciContext =  CIContext(mtlDevice : metalDevice)
		setupFilters()
    }
	
	//MARK: - САМ ФЛЬТР
	
    func setupFilters(){
        sepiaFilter?.setValue(NSNumber(value: 1), forKeyPath: "inputIntensity")
    }
	
    func applyFilters(inputImage image: CIImage) -> CIImage? {
        var filteredImage : CIImage?
        
        //apply filters
        sepiaFilter?.setValue(image, forKeyPath: kCIInputImageKey)
        filteredImage = sepiaFilter?.outputImage
              
        fadeFilter?.setValue(image, forKeyPath: kCIInputImageKey)
        filteredImage = fadeFilter?.outputImage
        
        return filteredImage
    }
	
	
	
    
    //MARK:- Camera Setup
    func setupAndStartCaptureSession(){
        DispatchQueue.global(qos: .userInitiated).async{
            //init session
            self.captureSession = AVCaptureSession()
            //start configuration
            self.captureSession.beginConfiguration()
            
            //session specific configuration
            if self.captureSession.canSetSessionPreset(.photo) {
                self.captureSession.sessionPreset = .photo
            }
            self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
            
            //setup inputs
            self.setupInputs()
            
            //setup output
            self.setupOutput()
            
            //commit configuration
            self.captureSession.commitConfiguration()
            //start running it
            self.captureSession.startRunning()
        }
    }
    
    func setupInputs(){
        //get back camera
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            backCamera = device
        } else {
            //handle this appropriately for production purposes
            fatalError("no back camera")
        }
        
        //get front camera
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            frontCamera = device
        } else {
            fatalError("no front camera")
        }
        
        //now we need to create an input objects from our devices
        guard let bInput = try? AVCaptureDeviceInput(device: backCamera) else {
            fatalError("could not create input device from back camera")
        }
        backInput = bInput
        if !captureSession.canAddInput(backInput) {
            fatalError("could not add back camera input to capture session")
        }
        
        guard let fInput = try? AVCaptureDeviceInput(device: frontCamera) else {
            fatalError("could not create input device from front camera")
        }
        frontInput = fInput
        if !captureSession.canAddInput(frontInput) {
            fatalError("could not add front camera input to capture session")
        }
        
        //connect back camera input to session
        captureSession.addInput(backInput)
    }
    
    func setupOutput(){
        videoOutput = AVCaptureVideoDataOutput()
        let videoQueue = DispatchQueue(label: "videoQueue", qos: .userInteractive)
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        } else {
            fatalError("could not add video output")
        }
        
        videoOutput.connections.first?.videoOrientation = .portrait
    }
    
    
    func switchCameraInput(){
        //don't let user spam the button, fun for the user, not fun for performance
        switchCameraButton.isUserInteractionEnabled = false
        
        //reconfigure the input
        captureSession.beginConfiguration()
        if backCameraOn {
            captureSession.removeInput(backInput)
            captureSession.addInput(frontInput)
            backCameraOn = false
        } else {
            captureSession.removeInput(frontInput)
            captureSession.addInput(backInput)
            backCameraOn = true
        }
        
        //deal with the connection again for portrait mode
        videoOutput.connections.first?.videoOrientation = .portrait
        
        //mirror the video stream for front camera
        videoOutput.connections.first?.isVideoMirrored = !backCameraOn
        
        //commit config
        captureSession.commitConfiguration()
        
        //acitvate the camera button again
        switchCameraButton.isUserInteractionEnabled = true
    }
    
    //MARK:- Actions
    @objc func captureImage(_ sender: UIButton?){
        takePicture = true
    }
    
    @objc func switchCamera(_ sender: UIButton?){
        switchCameraInput()
    }

}

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

		// пытаемся получить CVImageBuffer из буфера выборки
		guard let cvBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        //get a CIImage out of the CVImageBuffer
        let ciImage = CIImage(cvImageBuffer: cvBuffer)
		
        //filter it
        guard let filteredCIImage = applyFilters(inputImage: ciImage) else {
            return
        }
        
        self.currentCIImage = filteredCIImage
        
        mtkView.draw()
        
        //get UIImage out of CIImage
        let uiImage = UIImage(ciImage: ciImage)
        
        if !takePicture {
            return // мы не имеем ничего общего с буфером изображений
        }
        
        DispatchQueue.main.async {
            self.capturedImageView.image = uiImage
            self.takePicture = false
        }
    }
        
}

//MARK: METAL VIEW DELEGATE

extension ViewController : MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        //сообщает нам, что размер чертежа изменился
    }
    
    func draw(in view: MTKView) {
        //this is where we render to the screen
		
		// создаем буфер команд для ciContext, который будет использовать его для кодирования инструкций рендеринга в наш GPU
        guard let commandBuffer = metalCommandQueue.makeCommandBuffer() else {
            return
        }
        
        //убеждаемся, что у нас действительно есть ciImage для работы
        guard let ciImage = currentCIImage else {
            return
        }
        
        //убедитесь, что текущий объект для рисования для этого вида металла доступен (он не использовался в предыдущем цикле рисования)
        guard let currentDrawable = view.currentDrawable else {
            return
        }
		
        // убедитесь, что рамка находится по центру экрана
        let heightOfciImage = ciImage.extent.height
        let heightOfDrawable = view.drawableSize.height
        let yOffsetFromBottom = (heightOfDrawable - heightOfciImage)/2
        
        // рендеринг в металлическую текстуру
		/*
			image- Все просто; это CIImageмы создаем для каждого кадра.
			texture- Я сказал, что мы визуализируем его на экране через металлический вид, и упомянул, что мы будем использовать его с возможностью рисования.
		На самом деле мы «рисуем» текстуру объекта, в котором находится металлический вид. Текстура в смысле графического процессора - это изображение, которое используется для отображения на объект.
		Подумайте о пакетах текстур в видеоиграх.
		
			commandBuffer - Ранее мы создавали очередь команд, чтобы отправлять инструкции на GPU. Эти «инструкции» представлены в виде буферов команд и создаются из очереди команд.
		
			bounds- Это способ GCRectотрисовки изображения на текстуре.
			colorSpace- Это говорит о CIContextтом, как интерпретировать информацию о цвете из CIImage. Для нас это просто стандартные цвета RGB.
		*/
		
        self.ciContext.render(ciImage,
                              to: currentDrawable.texture,
                   commandBuffer: commandBuffer,
                          bounds: CGRect(origin: CGPoint(x: 0, y: -yOffsetFromBottom), size: view.drawableSize),
                      colorSpace: CGColorSpaceCreateDeviceRGB())
        
        // регистрируем, где рисовать инструкции в буфере команд после его выполнения
        commandBuffer.present(currentDrawable)
        // фиксируем команду в очереди для выполнения
        commandBuffer.commit()
		
		
    }
}
