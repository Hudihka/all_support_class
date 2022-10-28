//
//  CustomView.swift
//  tableView
//
//  Created by Username on 18.06.2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit

class CustomView: UIView {

    @IBOutlet var counteinerView: UIView!

    override init (frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        settingsView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        settingsView()
    }

    private func settingsView() {
        self.counteinerView.backgroundColor = UIColor.clear
    }

    func xibSetup() {
        counteinerView = loadViewFromNib("CustomView") //здесь прописываете название вашего класса
        counteinerView.frame = bounds
        counteinerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(counteinerView)
    }
}


extension UIView {
    @objc func loadViewFromNib(_ name: String) -> UIView { //добавление вью созданной в ксиб файле
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            return view
        } else {
            return UIView()
        }
    }
}
