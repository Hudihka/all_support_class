//
//  MultimediaOpportunities.swift
//  VideoPlayer
//
//  Created by Админ on 19.08.2020.
//  Copyright © 2020 Админ. All rights reserved.
//


import Foundation
import AVFoundation
import Photos


class  MultimediaOpportunities: NSObject {
    
    //MARK: - MULTI MEDIA
    
    enum StatusAccess {
        case permitted      //доступ разрещен
        case ban            //доступ запрещен
        case pressTrue      //разрешил доступ
        case pressBan       //запретил доступ
        case noValue        //не определился
    }
    
    static func checkCamera(completion: @escaping (StatusAccess) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            completion(.ban)
        case .restricted:
            completion(.noValue)
        case .authorized:
            //доступ разрещен
            completion(.permitted)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    completion(.pressTrue)
                    //нажал разрешить
                } else {
                    completion(.pressBan)
                }
            }
        }
    }
    
    
    static func checkPhotoLibraryPermission(completion: @escaping (StatusAccess) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            completion(.permitted)
        //доступ разрещен
        case .limited: //ios 14 ограниченный доступ
            completion(.permitted)
        case .denied, .restricted :
            completion(.ban)
        case .notDetermined://не определился
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    completion(.permitted)
                case .denied, .restricted:
                    completion(.noValue)
                case .notDetermined:
                    completion(.noValue)
                case .limited: //ios 14 ограниченный доступ
                    completion(.permitted)
                }
            }
        }
    }
    
    //разрещен доступ к фото
    
    static var accessAllowedPhotos: Bool{
        if PHPhotoLibrary.authorizationStatus() == .authorized{
            return true
        }
        
        return false
    }
    
    //разрещен доступ к камере
    
    static var accessAllowedCamera: Bool{
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized{
            return true
        }
        
        return false
    }
    
    
    static var noAccessMultimedia: Bool{ //нет доступа к мультимедиа
        if accessAllowedPhotos == false, accessAllowedCamera == false{
            return true
        }
        
        return false
    }
    
    static var userSeeAlerts: Bool{ //Юзер уже видел алерты о допуске
        if PHPhotoLibrary.authorizationStatus() != .notDetermined, AVCaptureDevice.authorizationStatus(for: .video) != .notDetermined{
            return true
        }
        
        return false
    }
    
    
}


