//
//  ViewController.swift
//  maskaNumber
//
//  Created by Hudihka on 22/01/2019.
//  Copyright © 2019 konstantinRAZRAB. All rights reserved.
//

import UIKit
import AnyFormatKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.textField.delegate = self
        self.textField.clipsToBounds = true
        self.textField.placeholder = "введите номер"
    }

    func textField (_ textField: UITextField,
                    shouldChangeCharactersIn range: NSRange,
                    replacementString string: String) -> Bool {

        return true
    }

    @IBAction func tap(_ sender: UITapGestureRecognizer) {

        self.exitKey()

    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == self.textField && textField.text?.count == 0 {
            textField.text = "+7 "
        }

    }


    func exitKey() {

        self.textField.resignFirstResponder()

        if self.textField.text?.count ?? 0 < 20 {
            self.textField.text = ""
            self.textField.placeholder = "введите номер"
        }

    }
}

