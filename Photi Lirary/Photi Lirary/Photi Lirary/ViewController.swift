//
//  ViewController.swift
//  Photi Lirary
//
//  Created by Hudihka on 18/07/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageCat: UIImageView!
    let pickerVC = UIImagePickerController()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func goAction(_ sender: Any) {
        presentStartAlert()
    }

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, ProtocolPhotoSelection {

    func presentStartAlert() {
        let alert = UIAlertController(title: nil, message: "ДОБАВИТЬ ИЗОБРАЖЕНИЕ", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Выбрать из библиотеки", style: .default, handler: { (_) in
            ApplicationOpportunities.checkPhotoLibraryPermission(completion: { (value) in
                switch value {
                case .pressBan:
                    break

                case .ban:
                    self.alertNoAccess(camera: false)

                case .permitted, .pressTrue:
                    if let VC = PhotosVC.route() {
                        VC.delegate = self
                        self.present(VC, animated: true, completion: nil)
                    }
                }
            })
        }))

        alert.addAction(UIAlertAction(title: "Сделать фотографию", style: .default, handler: { (_) in
            ApplicationOpportunities.dismisCameraVC(completion: { (status) in
                switch status {
                case .ban:
                    self.alertNoAccess(camera: true)

                case .permitted, .pressTrue:
                    self.openFotoCamera()

                case .pressBan:
                    return
                }
            })
        }))

        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel)
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        alert.addAction(cancelAction)

        self.present(alert, animated: true)
    }

    private func alertNoAccess(camera: Bool) {
        let textTitle = camera ? "Доступ к камере запрещен" : "Доступ к фотографиям запрещен"
        let description = "Разрешите приложению GinzaGO доступ в настройках"

        let alert = UIAlertController(title: textTitle, message: description, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Перейти в настройки", style: UIAlertAction.Style.default, handler: { (_) in
            ApplicationOpportunities.openAppSettings()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

    private func openFotoCamera() {
        pickerVC.delegate = self
        pickerVC.allowsEditing = true
        pickerVC.sourceType = .camera
        self.present(pickerVC, animated: true, completion: nil)
    }
    // MARK: - Получение выбранных изображений

    func newYourImage(image: UIImage) {
        imageCat.image = image
    }

    //сделал фото

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let chosenImage = info[.editedImage] as? UIImage {
            pickerVC.dismiss(animated: true, completion: nil)
            imageCat.image = chosenImage
        }
    }
}
