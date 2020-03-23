//
//  PreviewViewController.swift
//  CustomCamera
//
//  Created by DUYET on 6/9/17.
//  Copyright © 2017 Zero2Launch. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = self.image
        // Do any additional setup after loading the view.
    }
    @IBAction func cancelButton_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButton_TouchUpInside(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        dismiss(animated: true, completion: nil)
    }
}
