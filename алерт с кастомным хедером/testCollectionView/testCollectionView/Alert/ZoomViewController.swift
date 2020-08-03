//
//  ZoomViewController.swift
//  testCollectionView
//
//  Created by Админ on 03.08.2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController {

    private var imageScrollView: ImageScrollView!
    private var imageZoom: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageScrollView = ImageScrollView(frame: view.bounds)
        view.addSubview(imageScrollView)
        setupImageScrollView()
        
        if let imageZoom = imageZoom {
            self.imageScrollView.set(image: imageZoom)
        }
    }
    

    
    static func route(image: UIImage) -> ZoomViewController{
        let storubord = UIStoryboard(name: "Main", bundle: nil)
        let VC = storubord.instantiateViewController(withIdentifier: "ZoomViewController") as! ZoomViewController
        VC.imageZoom = image
        return VC
    }
    
    private func setupImageScrollView() {
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }


}
