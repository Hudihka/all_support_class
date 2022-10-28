//
//  ViewController.swift
//  iBeaconScaner
//
//  Created by Константин Ирошников on 09.07.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    private enum Constants {
        static let uuid = "02CABDE2-47A6-4601-8C8B-FA23A9860D0F"
        static let tracking = "ОТСЛЕЖИВАЙ"
        static let noTracking = "НЕ ОТСЛЕЖИВАЙ"
    }

    private let locationManager = CLLocationManager()
    private var region: CLBeaconIdentityConstraint? {
        guard let uuid = UUID(uuidString: Constants.uuid) else {
            return nil
        }

        return CLBeaconIdentityConstraint(uuid: uuid)
    }

    @IBOutlet weak var buttonGo: UIButton!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var labelInformation: UILabel!

    private var trackingStatus: Bool = false {
        didSet {
            let text = trackingStatus ? Constants.noTracking : Constants.tracking
            buttonGo.setTitle(text, for: .normal)

            if trackingStatus == false {
                labelDistance.text = nil
                labelInformation.text = nil
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    @IBAction func buttonGo(_ sender: Any) {
        guard let region = region else {
            return
        }

        if trackingStatus == false {
            locationManager.startRangingBeacons(satisfying: region)
        } else {
            locationManager.stopRangingBeacons(satisfying: region)
        }

        trackingStatus = !trackingStatus
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didRange beacons: [CLBeacon],
        satisfying beaconConstraint: CLBeaconIdentityConstraint
    ) {
        guard let beacon = beacons.filter({ $0.proximity != .unknown }).first else {
            trackingStatus = false
            return
        }

        labelDistance.text = "\(String(format: "%.3f", beacon.accuracy)) m"
        labelInformation.text = "Mj: \(beacon.major), mi: \(beacon.minor)"
    }
}
