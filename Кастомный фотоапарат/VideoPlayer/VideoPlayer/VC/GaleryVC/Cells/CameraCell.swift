//
//  CameraCell.swift
//  VideoPlayer
//
//  Created by Админ on 19.08.2020.
//  Copyright © 2020 Админ. All rights reserved.
//

import UIKit
import AVFoundation

class CameraCell: UICollectionViewCell {
    
    @IBOutlet weak var photoView: UIView!
    
    private var accessCamera: Bool {
        return MultimediaOpportunities.accessAllowedCamera
    }
    
    //камера
    
    var captureSession = AVCaptureSession() //сессия захвата медиа
    
    var currentCamrera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput? ///класс захвата изображения
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?  //слой видео в момент его захвата
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if accessCamera == true {
            captureSession.sessionPreset = AVCaptureSession.Preset.photo
            
            setupDevice()           //настройки девайса
            setupInputOutput()      //настроить вход-выход
            setupPreviewLayer()     //настройка слоя фотокамеры
            startRunningCaptureSession()
        }
    
    }
    
    
    deinit {
        if accessCamera == true {
            captureSession.stopRunning()
        }
    }
    
}

extension CameraCell: AVCapturePhotoCaptureDelegate {
    
    func setupDevice() {
        //Запрос для поиска и мониторинга доступных устройств захвата.
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        //Массив доступных в настоящее время устройств, соответствующих критериям сеанса.
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                currentCamrera = device
            }
        }
    }
    
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamrera!) //захват того что есть сейчас
            captureSession.addInput(captureDeviceInput)//Добавляет заданный вход в сеанс.
            photoOutput = AVCapturePhotoOutput()       //Выходные данные захвата для неподвижного изображения, Live Photo и других рабочих процессов фотографии.
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecJPEG])], completionHandler: nil) //полученное фото
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
    
    private func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        //Указывает, как слой отображает видеоконтент в своих границах.
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.frame
        self.photoView.layer.insertSublayer(cameraPreviewLayer!, at: 0)
        
    }
    
    func startRunningCaptureSession() {
        captureSession.startRunning() //запускаем сессию
    }
    
}
