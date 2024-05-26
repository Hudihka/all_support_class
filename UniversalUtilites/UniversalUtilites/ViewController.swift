//
//  ViewController.swift
//  UniversalUtilites
//
//  Created by Худышка К on 25.05.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let image = UIImageView().setImage(UIImage(named: "cloth"))
    let label = UILabel().setAligment(.center)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Пример использования
        view.addSubview(image)
        image.snp.makeConstraints({
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(100)
        })
        
        view.addSubview(label)
        label.snp.makeConstraints({
            $0.top.left.right.equalToSuperview().inset(100)
        })
        
        label.text = "test text"
        
        view.backgroundColor = UIColor(named: "testColor1")
    }


}
