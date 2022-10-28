//
//  ViewController.swift
//  Bluetooth
//
//  Created by Константин Ирошников on 05.07.2022.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {

    var cbCentralManager: CBCentralManager?
    var peripheral: CBPeripheral?

    override func viewDidLoad() {
        super.viewDidLoad()

        cbCentralManager = CBCentralManager(delegate: self, queue: nil)
    }


}

extension ViewController: CBCentralManagerDelegate {
    /*
     Вы реализуете этот обязательный метод, чтобы гарантировать, что центральное
     устройство поддерживает Bluetooth с низким энергопотреблением и доступно для использования.
     */
    func centralManagerDidUpdateState(_ central: CBCentralManager) {

        switch central.state {
        case .poweredOn:
            // withServices это UIID устройств которые мы будем искать
            // если нил, то ищет все

//            let ids = [
//                CBUUID(string: "5376B04C-B563-4897-9E82-71A31FBFA937"),
//                CBUUID(string: "D0611E78-BBB4-4591-A5F8-487910AE4366")// мак бук
//                CBUUID(string: "9FA480E0-4967-4542-9390-D343DC5D04AE")
//                CBUUID(string: "8667556C-9A37-4C91-84ED-54EE27D90049")
//                CBUUID(string: "AF0BADB1-5B99-43CD-917A-A77BC549E3CC")
//            ]

//            central.scanForPeripherals(withServices: ids, options: nil)

            central.scanForPeripherals(withServices: nil, options: nil)
            print("Scanning...")
        case .poweredOff:
            print("выключено")
        case .unknown:
            print("Состояние менеджера неизвестно.")
        case .resetting:
            print("Состояние, указывающее, что соединение с системной службой было на мгновение потеряно.")
        case .unsupported:
            print("Состояние, указывающее, что это устройство не поддерживает центральную или клиентскую роль Bluetooth с низким энергопотреблением.")
        case .unauthorized:
            print("Состояние, указывающее, что приложению не разрешено использовать роль Bluetooth с низким энергопотреблением.")
        }
    }

    /*
     найдет периферийное BLE-устройство, мы сможем подключиться и сохранить его копию
     */

    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String : Any],
        rssi RSSI: NSNumber
    ) {
        guard let name = peripheral.name else {return}

        print(name)

        // можем проверить по имени
//        if name == "iPhone (Худышка) (2)" {
//            print(peripheral.identifier)
//
//            cbCentralManager?.stopScan()
//
//            //connect
//            cbCentralManager?.connect(peripheral, options: nil)
//            self.peripheral = peripheral
//        }
    }

    /*
     Сообщает делегату, что центральный менеджер подключен к периферийному устройству.
     */
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
      /*
       если вы передадите Nil, он обнаружит все службы,
       но если вы знаете конкретную службу, вы можете обнаружить только ее.
       */

      peripheral.discoverServices(nil)
      peripheral.delegate = self
    }

}

// делегат переферийного устройства
extension ViewController: CBPeripheralDelegate {

    // после того как нашли все сервисы, ищем нужную характеристику
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        /*
         сервисы для айфона
         [
         <CBService: 0x2831f8840, isPrimary = YES, UUID = Continuity>,
         <CBService: 0x2831f8800, isPrimary = YES, UUID = 9FA480E0-4967-4542-9390-D343DC5D04AE>,
         <CBService: 0x2831f8380, isPrimary = YES, UUID = Battery>,
         <CBService: 0x2831f8040, isPrimary = YES, UUID = Current Time>,
         <CBService: 0x2831f81c0, isPrimary = YES, UUID = Device Information>

         или же

         - 0 : "D0611E78-BBB4-4591-A5F8-487910AE4366"
         - 1 : "9FA480E0-4967-4542-9390-D343DC5D04AE"
         - 2 : "180F"
         - 3 : "1805"
         - 4 : "180A"

         ]
         */
        guard let servis = peripheral.services?.first(where: { $0.uuid.uuidString == "180F"}) else {
            return
        }
        peripheral.discoverCharacteristics(nil, for: servis)


        // это все сервисы
//        if let services = peripheral.services {
//            print(services)
//
//            for service in services {
//                peripheral.discoverCharacteristics(nil, for: service)
//            }
//        }
    }

    // далее смотрим характеристики, и ищем нужную

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {

        guard let characteristics = service.characteristics else {
            return
        }

        // возможность получения уровня заряда батареи
        for newChar in characteristics {
            if newChar.uuid == CBUUID(string: "0x2A19") {
                // чтение значений
               peripheral.readValue(for: newChar)
                // чтение получение нотификаций
                peripheral.setNotifyValue(true, for: newChar)

                peripheral.readRSSI()
            }
        }
    }

    func peripheral(
        _ peripheral: CBPeripheral,
        didUpdateValueFor characteristic: CBCharacteristic,
        error: Error?
    ) {
        print("чтение значений")
        print(characteristic.value as Any)
        print("Battery level: \(characteristic.value![0])")
    }

    func peripheral(
        _ peripheral: CBPeripheral,
        didUpdateNotificationStateFor characteristic: CBCharacteristic,
        error: Error?
    ) {
        print("получение нотификаций")
        print(characteristic.value as Any)
        print("Battery level update: \(characteristic.value![0])")
    }

    // уровень сигнала
    func peripheral(
        _ peripheral: CBPeripheral,
        didReadRSSI RSSI: NSNumber,
        error: Error?
    ) {
        print("новое rssi2: \(peripheral.rssi)")
        print("RSSI: \(RSSI)")
    }
}
