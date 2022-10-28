//
//  BeaconManager.swift
//  iBeaconMyPhone
//
//  Created by Константин Ирошников on 08.07.2022.
//

import UIKit
import Foundation
import CoreLocation
import CoreBluetooth

protocol BeaconManagerDelegate {
    func stopAdvertising()
    func startAdvertising()

    var showAlert: (String) -> Void { get set }
}

class BeaconManager: NSObject, BeaconManagerDelegate {

    private var beaconRegion: CLBeaconRegion?
    private let peripheralManager = CBPeripheralManager()  // beacon

    var showAlert: (String) -> Void = { _ in }

    override init() {
        super.init()
        peripheralManager.delegate = self

        createBeaconRegion()
    }

    func startAdvertising() {

        guard let beaconRegion = beaconRegion else { return }

        if peripheralManager.state == .poweredOn {
            advertiseDevice(region: beaconRegion)
        }
    }

    private func advertiseDevice(region : CLBeaconRegion) {
        let peripheralData = region.peripheralData(withMeasuredPower: nil) as? [String : Any]
        if peripheralManager.isAdvertising { peripheralManager.stopAdvertising() }
        peripheralManager.startAdvertising(peripheralData)
    }

    func stopAdvertising() {
        if peripheralManager.isAdvertising {
            peripheralManager.stopAdvertising()
        }
    }

    private func createBeaconRegion() {
        guard
            let deviceID = UIDevice.current.identifierForVendor?.uuidString,
            let proximityUUID = UUID(uuidString: deviceID)
        else {
            return
        }

        let major = CLBeaconMajorValue(101)
        let minor = UInt16(202)

        let beaconIdentityConstraint = CLBeaconIdentityConstraint(
            uuid: proximityUUID,
            major: major,
            minor: minor
        )

        beaconRegion = CLBeaconRegion(
            beaconIdentityConstraint: beaconIdentityConstraint,
            identifier: "this id Beacon"
        )
    }
}


extension BeaconManager: CBPeripheralManagerDelegate {

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {

        switch peripheral.state {
            case .unknown:
                print("unknown")
            case .resetting:
                print("resetting")
            case .unsupported:
                showAlert("Не поддерживается блютус")
            case .unauthorized:
                print("unauthorized")
            case .poweredOff:
                print("Bluetooth powered off")
                peripheralManager.stopAdvertising()
            case .poweredOn:
                print("Bluetooth powered on")
            default:
                print("❌ Check for additional cases of state on CBCentralManager ")
        }
    }
}

