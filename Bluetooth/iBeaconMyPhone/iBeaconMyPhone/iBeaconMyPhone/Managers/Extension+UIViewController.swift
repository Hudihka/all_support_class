//
//  AlertManager.swift
//  iBeaconMyPhone
//
//  Created by Константин Ирошников on 08.07.2022.
//

import UIKit

extension UIViewController {
    func showAlert(
        title: String = "Титульник",
        message: String
    ) {

        /// create the body of the alert
        let alert = UIAlertController(
            title  : title,
            message: message,
            preferredStyle: .alert
        )

        /// add an action (button)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)

        present(alert, animated: true, completion: nil)
    }
}
