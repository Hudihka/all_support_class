//
//  ApplicationOpportunities.swift
//  GinzaGO
//
//  Created by Hudihka on 31/03/2019.
//  Copyright © 2019 ITMegastar. All rights reserved.

import UIKit
import UserNotifications
import PassKit
import AVFoundation
import Photos

enum PhotoStatus {
    case permitted      //доступ разрещен
    case ban            //доступ запрещен
    case pressTrue      //разрешил доступ
    case pressBan       //запретил доступ
    case noValue        //не определился
}

class ApplicationOpportunities: NSObject {
    static var pushNotificStatus = false

    static func locationActive(completion: @escaping (Bool) -> Void ) { //включена ли геоолокация
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                completion(false)

            case .authorizedAlways, .authorizedWhenInUse:
                completion(true)
            }
        } else {
            completion(false)
        }
    }

    static func userIHaveNotdecidedGeolocation() -> Bool { //TRUE если еще не определился
        if CLLocationManager.locationServicesEnabled() {
            return CLLocationManager.authorizationStatus() == .notDetermined
        }
        return true
    }

    static func getNotificationActive() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                ApplicationOpportunities.pushNotificStatus = settings.authorizationStatus == .authorized
            }
        } else {
            ApplicationOpportunities.pushNotificStatus = UIApplication.shared.isRegisteredForRemoteNotifications
        }
    }

    static func isSupportsDeviceApplePay() -> Bool {
        if #available(iOS 11.0, *) {   //с эпл пей
            let arrayNetwork: [PKPaymentNetwork] = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex]
            let capaboloties = PKMerchantCapability.capability3DS

            if PKPaymentAuthorizationController.canMakePayments(usingNetworks: arrayNetwork, capabilities: capaboloties) {
                return true
            }
        }

        return false
    }

    static func dismisCameraVC(completion: @escaping (PhotoStatus) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            completion(.ban)
        //нельзя
        case .restricted:
            print("ppppp")

        case .authorized:
            print("Authorized, proceed")
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

    static func checkPhotoLibraryPermission(completion: @escaping (PhotoStatus) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            completion(.permitted)

        case .denied, .restricted :
            completion(.ban)
        case .notDetermined://не определился
            KeysUDef.askedQuestionPfotoLibs.saveBool(true)
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    print("Authorized, proceed")
                    completion(.permitted)

                case .denied, .restricted:
                    print("Authorized, proceed")

                case .notDetermined:
                    print("Authorized, proceed")
                }
            }
        }
    }

    static func versionAplication() -> String {
        guard let appVersion = Bundle.main.infoDictionary else {
            return "1.0"
        }

        let version = appVersion["CFBundleShortVersionString"] as? String
        return version ?? "1.0"
    }
}
