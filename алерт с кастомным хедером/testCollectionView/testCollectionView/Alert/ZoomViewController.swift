//
//  ZoomViewController.swift
//  testCollectionView
//
//  Created by Админ on 03.08.2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import Foundation
import UIKit

class ZoomViewController: UIViewController {

    @IBOutlet weak var imageHoll: UIImageView!
    private var imageScrollView: ImageScrollView!
    private var imageZoom: UIImage?
	
    
    var saveBlock: () -> ()  = {   }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imageScrollView = ImageScrollView(frame: view.frame)
        view.addSubview(imageScrollView)
        setupImageScrollView()

        if let imageZoom = imageZoom {
            self.imageScrollView.set(image: imageZoom)
        }
        
        addImageHoll()
    }

    
    static func route(image: UIImage) -> ZoomViewController{
        let storubord = UIStoryboard(name: "Main", bundle: nil)
        let VC = storubord.instantiateViewController(withIdentifier: "ZoomViewController") as! ZoomViewController
        VC.imageZoom = image
        return VC
    }
    
    private func setupImageScrollView() {
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    private func addImageHoll(){
        
        let imageView = UIImageView(frame: self.view.frame)
        imageView.image = UIImage(named: "Subtract")
        imageView.contentMode = .scaleAspectFill
        
        self.view.addSubview(imageView)
        
    }

    @IBAction func saveAction(_ sender: Any) {
        
        
    }
    
    

}
