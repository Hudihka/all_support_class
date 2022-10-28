//
//  ViewController.swift
//  CustomCamera
//
//  Created by DUYET on 6/9/17.
//  Copyright © 2017 Zero2Launch. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet weak var cameraButton: UIButton!
    var captureSession = AVCaptureSession() //сессия захвата медиа

    //ну собственно все камеры
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamrera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput? ///класс захвата изображения
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?  //слой видео в момент его захвата
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //создаем сессию захвата медиа
        //сообщая параметры которые будут нам необходимы
        //в данном случае только для фото
        captureSession.sessionPreset = AVCaptureSession.Preset.photo

        setupDevice()           //настройки девайса
        setupInputOutput()      //настроить вход-выход
        setupPreviewLayer()     //настройка слоя фотокамеры
        startRunningCaptureSession()

        //настраивает кнопку
        cameraButton.layer.borderColor = UIColor.white.cgColor
        cameraButton.layer.borderWidth = 5
        cameraButton.clipsToBounds = true
    }

    
    func setupDevice() {
                                                    //Запрос для поиска и мониторинга доступных устройств захвата.
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        //Массив доступных в настоящее время устройств, соответствующих критериям сеанса.
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }

        //это какую камеру мы будем использовать в данный момент
        currentCamrera = backCamera
    }
    
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamrera!) //захват того что есть сейчас
            captureSession.addInput(captureDeviceInput)//Добавляет заданный вход в сеанс.
            photoOutput = AVCapturePhotoOutput()       //Выходные данные захвата для неподвижного изображения, Live Photo и других рабочих процессов фотографии.
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil) //полученное фото
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
    
    func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        //Указывает, как слой отображает видеоконтент в своих границах.
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    func startRunningCaptureSession() {
        captureSession.startRunning() //запускаем сессию
    }
    
    @IBAction func cameraButton_TouchUpInside(_ sender: Any) {
        let settings = AVCapturePhotoSettings()                 //делаем фото
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto_Segue" {
            let previewVC = segue.destination as! PreviewViewController
            previewVC.image = self.image
        }
    }
    
}

extension ViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            image = UIImage(data: imageData)
            performSegue(withIdentifier: "showPhoto_Segue", sender: nil)
        }
    }
}


