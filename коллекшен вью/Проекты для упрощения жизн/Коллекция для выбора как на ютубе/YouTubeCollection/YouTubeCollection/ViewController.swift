//
//  ViewController.swift
//  YouTubeCollection
//
//  Created by Hudihka on 13/01/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewCollection: ViewCollection!
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCollection.delegate = self
    }


}

extension ViewController: ReloadImage{
    var image: UIImage? {
        get {
            return img.image
        }
        set {
            img.image = newValue
        }
    }
    
}

