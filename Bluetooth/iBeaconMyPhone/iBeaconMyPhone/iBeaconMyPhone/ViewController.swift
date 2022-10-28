//
//  ViewController.swift
//  iBeaconMyPhone
//
//  Created by Константин Ирошников on 08.07.2022.
//

import UIKit

class ViewController: UIViewController {

    private let beaconManager = BeaconManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        beaconManager.showAlert = { [weak self] message in
            self?.showAlert(message: message)
        }
    }

    @IBAction func actionStart(_ sender: Any) {
        beaconManager.startAdvertising()
    }

    @IBAction func stopButton(_ sender: Any) {
        beaconManager.stopAdvertising()
    }
}

