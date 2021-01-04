//
//  ViewController.swift
//  TestFilterProject
//
//  Created by Anastasia Sokolan on 22.09.2020.
//  Copyright © 2020 Anastasia Sokolan. All rights reserved.
//

import CoreImage
import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Private Properties
        
    private var imageView = UIImageView()
    
    private var image: UIImage!
    
    private var filterWorker: FilterWorker!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        image = UIImage(named: "sunset")!
        
        filterWorker = FilterWorker(image: image)
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit

        containerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor)
        ])
    }
    
    // MARK: - IBActions
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let filteredImage = filterWorker.applyUIImage(with: sender.value)
        imageView.image = filteredImage
    }
}
