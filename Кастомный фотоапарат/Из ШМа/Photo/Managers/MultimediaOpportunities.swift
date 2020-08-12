//
//  MultimediaOpportunities.swift
//  ChefMarket_2.0
//
//  Created by Админ on 04.08.2020.
//  Copyright © 2020 itMegaStar. All rights reserved.
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
        case .denied, .restricted :
            completion(.ban)
        case .notDetermined://не определился
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    print("Authorized, proceed")
                    completion(.permitted)
                    
                case .denied, .restricted:
                    print("Authorized, proceed")
                    completion(.noValue)
                    
                case .notDetermined:
                    print("Authorized")
                    completion(.noValue)
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
    
}
