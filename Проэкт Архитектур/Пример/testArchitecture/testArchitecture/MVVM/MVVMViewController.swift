//
//  MVVMViewController.swift
//  testArchitecture
//
//  Created by Константин Ирошников on 16.09.2022.
//

import Foundation
import UIKit
import SnapKit

final class MVVMViewController: BaseViewController {
    
    var VM: (MVVMProtocolIn & MVVMProtocolOut)?

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        label.text = "MVVM"

        return label
    }()
    private let spiner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .black
        view.style = .large

        return view
    }()
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("понеслась", for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func listenViewModel() {
        guard var VM = VM else {
            return
        }
        
        VM.showText = { [weak self] text in
            self?.showText(text: text)
        }
    }

    override func layoutVC() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.height.equalTo(150)
            make.left.right.equalTo(0)
        }

        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.bottom.equalTo(-50)
            make.height.equalTo(50)
            make.left.equalTo(25)
            make.right.equalTo(-25)
        }

        view.addSubview(spiner)
        spiner.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
        }
    }

    @objc
    private func tapButton() {
        spiner.startAnimating()
        button.isHidden = true
        
        VM?.getText()
    }
    
    private func showText(text: String) {
        spiner.stopAnimating()
        button.isHidden = false
        
        let oldText = label.text ?? ""
        
        label.text = oldText + text
    }

}
