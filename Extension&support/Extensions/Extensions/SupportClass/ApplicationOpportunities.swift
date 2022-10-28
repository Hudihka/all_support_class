//
//  ApplicationOpportunities.swift
//  GinzaGO
//
//  Created by Hudihka on 31/03/2019.
//  Copyright © 2019 Hudihka. All rights reserved.

import UserNotifications
import UIKit
import PassKit
import CoreLocation
import AVFoundation
import Photos

class ApplicationOpportunities: NSObject {
	
	//MARK: - MULTI MEDIA
	
	enum StatusAccess {
		case permitted      //доступ разрещен
		case ban            //доступ запрещен
		case pressTrue      //разрешил доступ
		case pressBan       //запретил доступ
		case noValue        //не определился
	}
	
	static func dismisCameraVC(completion: @escaping (StatusAccess) -> Void) {
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

					case .notDetermined:
						print("Authorized")
					}
				}
			}
		}
    
	static func activePush(compl:@escaping(Bool) -> Void){
		if #available(iOS 10.0, *) {
            
            DispatchQueue.global(qos: .userInteractive).sync{
                UNUserNotificationCenter.current().getNotificationSettings {(settings) in
                    DispatchQueue.main.async {
						compl(settings.authorizationStatus == .authorized)
					}
                }
            }
            
        } else {
			compl(UIApplication.shared.isRegisteredForRemoteNotifications)
        }
	}
	
	//MARK: - Location
	
	func locationActive(completion: @escaping (Bool) -> Void ) { //включена ли геоолокация
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
	
	static var userIHaveNotdecidedGeolocation: Bool { //TRUE если еще не определился
        if CLLocationManager.locationServicesEnabled() {
            return CLLocationManager.authorizationStatus() == .notDetermined
        }
		
        return true
    }
	
	//MARK: - APPLE PAY
	
	static var isOnDeviceApplePay: Bool {
        if #available(iOS 11.0, *) {   //с эпл пей
            let arrayNetwork: [PKPaymentNetwork] = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex]
            let capaboloties = PKMerchantCapability.capability3DS

            if PKPaymentAuthorizationController.canMakePayments(usingNetworks: arrayNetwork, capabilities: capaboloties) {
                return true
            }
        }

        return false
    }
	
	
	//MARK: - получение доступа к микрофону
    private func checkRecordPermission(completion: @escaping(StatusAccess?) -> Void){

        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSession.RecordPermission.granted:
			completion(.permitted)
        case AVAudioSession.RecordPermission.denied:
			completion(.ban)
        case AVAudioSession.RecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
                completion(nil)
            })
        default:
            break
        }

    }
	
	

    static var versionAplication: String {
        guard let appVersion = Bundle.main.infoDictionary else {
            return "1.0"
        }

        let version = appVersion["CFBundleShortVersionString"] as? String
        return version ?? "1.0"
    }
}

