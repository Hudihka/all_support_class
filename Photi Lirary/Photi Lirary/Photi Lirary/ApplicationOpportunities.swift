

import UIKit
import AVFoundation
import Photos

enum PhotoStatus {
    case permitted      //доступ разрещен
    case ban            //доступ запрещен
    case pressTrue      //разрешил доступ
    case pressBan       //запретил доступ

}

class ApplicationOpportunities: NSObject {

    static func dismisCameraVC(completion: @escaping (PhotoStatus) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            completion(.ban)
        //нельзя
        case .restricted:
            break

        case .authorized:
            completion(.permitted)

        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    completion(.pressTrue)

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

            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    completion(.permitted)

                case .denied, .restricted:
                    break

                case .notDetermined:
                    break
                }
            }
        }
    }

    static func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
}
