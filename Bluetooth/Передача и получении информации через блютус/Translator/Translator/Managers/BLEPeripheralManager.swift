//
//  BLEPeripheralManager.swift
//  Translator
//
//  Created by Константин Ирошников on 10.07.2022.
//

import CoreBluetooth
import UIKit

let uuidIphoneX = "02CABDE2-47A6-4601-8C8B-FA23A9860D0F"
let uuidIphone13 = "31B22E69-D5C9-4F8F-B42F-6D052294D4D1"

class BLEPeripheralManager: NSObject {

    //MARK:- Properties

    static let shared = BLEPeripheralManager()

    //just some delegates for other classes
//    var peripheralDataReceiver: PeripheralDataReceiver?
//    var peripheralChatDataReceiver: PeripheralChatDataReceiver?

    var peripheralManager: CBPeripheralManager

    var subscribedCentrals: [CBCentral] = []

    var readCharacteristic: CBMutableCharacteristic = {
        let uuidChar1 = CBUUID(string: uuidIphoneX)
        let char = CBMutableCharacteristic(type: uuidChar1, properties: .read, value: nil, permissions: .readable)
        return char
    }()
    var writeCharacteristic: CBMutableCharacteristic = {
        let uuidChar2 = CBUUID(string: uuidIphone13)
        let char = CBMutableCharacteristic(type: uuidChar2, properties: .write, value: nil, permissions: .writeable)
        return char
    }()


    //MARK:- Private Methods

    private override init() {
        self.peripheralManager = CBPeripheralManager(delegate: nil, queue: nil)
        super.init()
        self.peripheralManager.delegate = self
    }
    

    private func setupManager() {
        let uuidServ = CBUUID(string: uuidIphone13)

        let transferService = CBMutableService(type: uuidServ, primary: true)
        transferService.characteristics = [self.readCharacteristic, self.writeCharacteristic]

        self.peripheralManager.add(transferService)
    }

    private func teardownServices() {
        self.peripheralManager.removeAllServices()
    }

    private func clearSubscribers() {
        self.subscribedCentrals.removeAll()
    }

    //MARK:- Public Methods

    func sendMessage(fromPeripheral peripheral: String, text: String) {
        if text.isEmpty { return }
        let chatMessage = text//ChatMsg(messageText: text, fromDevice: peripheral)
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(chatMessage)
            print(self.readCharacteristic.uuid)
            if self.peripheralManager.updateValue(data, for: self.readCharacteristic, onSubscribedCentrals: nil) == false {
                print("Update from Peripheral failed (ReadCharacteristic)")
            } else {
                print("Message sent (ReadCharacteristic)")
            }
            if self.peripheralManager.updateValue(data, for: self.writeCharacteristic, onSubscribedCentrals: nil) == false {
                print("Update from Peripheral failed (WriteCharacteristic)")
            } else {
                print("Message sent (WriteCharacteristic)")
            }
        } catch {
            print("Error in encoding data")
        }
    }

    func startAdvertising() {
        let services = [CBUUID(string: uuidIphone13)]
        let advertisingDict = [CBAdvertisementDataServiceUUIDsKey: services]

        self.peripheralManager.startAdvertising(advertisingDict)
    }
}


extension BLEPeripheralManager: CBPeripheralManagerDelegate {

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOff:
            print("Peripheral powered off")
            self.teardownServices()
            self.clearSubscribers()
        case .poweredOn:
            print("Peripheral powered on")
            self.setupManager()
        case .resetting:
            print("Peripheral resetting")
        case .unauthorized:
            print("Unauthorized Peripheral")
        case .unknown:
            print("Unknown Peripheral")
        case .unsupported:
            print("Unsupported Peripheral")
        @unknown default:
            return
        }
    }

    //doesn`t get called
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        for request in requests {
            if let value = request.value {
                if let messageText = String(data: value, encoding: String.Encoding.utf8) {
                    //
                }
            }
        }
    }

    //doesn`t get called
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        var shouldAdd: Bool = true
        for sub in self.subscribedCentrals {
            if sub == central {
                shouldAdd = false
            }
        }
        if shouldAdd { self.subscribedCentrals.append(central) }
    }

}
