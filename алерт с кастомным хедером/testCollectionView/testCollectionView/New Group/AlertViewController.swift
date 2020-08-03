//
//  AlertViewController.swift
//  testCollectionView
//
//  Created by Админ on 31.07.2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    fileprivate let pickerVC = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func playAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)

        
        let rect = CGRect(x: 0, y: 10, width: alertController.view.bounds.size.width - 17, height: 102)
        let customView = ViewHeaderAlert(frame: rect)
        customView.blockOpenCamera = {
            alertController.dismiss(animated: true) {
                 self.openFotoCamera()
            }
        }

        customView.backgroundColor = .clear
        alertController.view.addSubview(customView)

        let somethingAction = UIAlertAction(title: "Выбрать Фото", style: .default, handler: {(alert: UIAlertAction!) in print("something")})
        somethingAction.setValue(UIColor.black, forKey: "titleTextColor")
        
        let deleteAction = UIAlertAction(title: "Удалить Фото", style: .default, handler: {(alert: UIAlertAction!) in print("something")})
        deleteAction.setValue(UIColor.red, forKey: "titleTextColor")

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        cancelAction.setValue(UIColor.green, forKey: "titleTextColor")

        alertController.addAction(somethingAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion:{})
        
    }
    
    @IBAction func cameraVC(_ sender: Any) {
        
        let VC = MyCameraVC.route()
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
}

extension AlertViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    fileprivate func openFotoCamera() {

        pickerVC.delegate = self
        pickerVC.allowsEditing = false
        pickerVC.sourceType = .camera
		pickerVC.modalPresentationStyle = .overFullScreen
        
        self.navigationController?.present(pickerVC, animated: true, completion: nil)

    }

    //сделал фото

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let chosenImage = info[.originalImage] as? UIImage {
            pickerVC.dismiss(animated: true, completion: nil)
            let ZVC = ZoomViewController.route(image: chosenImage)
            ZVC.modalPresentationStyle = .overFullScreen
            self.present(ZVC, animated: true, completion: nil)
        }
    }
    
}

