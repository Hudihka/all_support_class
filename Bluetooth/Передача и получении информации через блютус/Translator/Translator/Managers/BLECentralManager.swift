//
//  Cen.swift
//  Translator
//
//  Created by Константин Ирошников on 11.07.2022.
//

import CoreBluetooth
import UIKit

class BLECentralManager: NSObject {

    static let shared = BLECentralManager()

    //just some delegates for other classes
    var centralDataReceiver: CentralDataReceiver?
    var centralChatDataReceiver: CentralChatDataReceiver?

    var centralManager: CBCentralManager

    var peripheralArray: [CBPeripheral] = []

    var writeTransferPeripheral: (peripheral: CBPeripheral, characteristic: CBCharacteristic)?
    var readTransferPeripheral: (peripheral: CBPeripheral, characteristic: CBCharacteristic)?

    private override init() {
        self.centralManager = CBCentralManager(delegate: nil, queue: nil, options: nil)
        super.init()
        self.centralManager.delegate = self
    }

    private func startScan() {
        self.centralManager.scanForPeripherals(withServices: [CBUUID(string: UUIDs.serviceUUID)], options: nil)
        //self.centralManager.scanForPeripherals(withServices: nil, options: nil)
    }

    public func connectTo(index: Int) {
        self.centralManager.connect(self.peripheralArray[index], options: nil)
    }

    public func sendMessage(fromPeripheral peripheral: String, text: String) {
        let chatMsg = ChatMsg(messageText: text, fromDevice: peripheral)
        let encoder = JSONEncoder()

        do {
            let data = try encoder.encode(chatMsg)
            self.writeTransferPeripheral?.peripheral.writeValue(data, for: (self.writeTransferPeripheral?.characteristic)!, type: .withoutResponse)
        } catch {
            print("Error in encoding data")
        }
    }

    public func getActiveConnections() -> String {
        var connString: String = ""
        let conns = self.centralManager.retrieveConnectedPeripherals(withServices: [CBUUID(string: UUIDs.serviceUUID)])
        for peri in conns {
            if connString == "" {
                connString = "\(peri)"
            } else {
                connString = "\(connString), \(peri)"
            }
        }
        return connString
    }

    public func getMessages() {
        self.readTransferPeripheral?.peripheral.readValue(for: (self.readTransferPeripheral?.characteristic)!)
    }

    public func lookForPeripherals() {
        self.peripheralArray.removeAll()
        self.startScan()
    }

    public func getPeripherals() -> [CBPeripheral] {
        return self.peripheralArray
    }

    private func getNameOfPeripheral(peripheral: CBPeripheral) -> String {
        if let name = peripheral.name {
            return name
        } else {
            return "Device"
        }
    }
}


extension BLECentralManager: CBCentralManagerDelegate, CBPeripheralDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            print("BLE has powered off")
            centralManager.stopScan()
        case .poweredOn:
            print("BLE is now powered on")
            self.startScan()
        case .resetting:
            print("BLE is resetting")
        case .unauthorized:
            print("Unauthorized BLE state")
        case .unknown:
            print("Unknown BLE state")
        case .unsupported:
            print("This platform does not support BLE")
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        self.peripheralArray.append(peripheral)
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        self.centralDataReceiver?.connectionEstablished(peripheral: peripheral)
        print("Connection Established")
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        self.centralDataReceiver?.connectionTornDown()
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services! {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic in service.characteristics! {
            print(characteristic.uuid)
            let char = characteristic as CBCharacteristic
            if char.uuid.uuidString == UUIDs.characteristicUUID2 {
                self.writeTransferPeripheral?.peripheral = peripheral
                self.writeTransferPeripheral?.characteristic = char
                self.writeTransferPeripheral?.peripheral.setNotifyValue(true, for: (self.writeTransferPeripheral?.characteristic)!)
            } else if char.uuid.uuidString == UUIDs.characteristicUUID1 {
                self.readTransferPeripheral?.peripheral = peripheral
                self.readTransferPeripheral?.characteristic = char
                self.readTransferPeripheral?.peripheral.setNotifyValue(true, for: (self.readTransferPeripheral?.characteristic)!)
            }
        }
    }

    //doesn`t get called
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if let data = characteristic.value {
            if data.isEmpty { return }
            if let text = String(data: characteristic.value!, encoding: String.Encoding.utf8) {
                self.centralChatDataReceiver?.receiveMessage(fromPeripheral: self.getNameOfPeripheral(peripheral: peripheral), text: text)
            }
        }
    }

    //doesn`t get called
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let data = characteristic.value {
            if data.isEmpty { return }
            if let text = String(data: characteristic.value!, encoding: String.Encoding.utf8) {
                self.centralChatDataReceiver?.receiveMessage(fromPeripheral: self.getNameOfPeripheral(peripheral: peripheral), text: text)
            }
        }
    }

    //doesn`t get called
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        print("Notification state changed")
    }

}
