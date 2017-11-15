//
//  Central.swift
//  ble
//
//  Created by keisuke ishikura on 2017/11/15.
//  Copyright © 2017年 keisuke ishikura. All rights reserved.
//


import CoreBluetooth


class Central: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var centralManager: CBCentralManager!
    var peripherals:[CBPeripheral] = []
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch (central.state){
        case .poweredOn:
            
            scan()
            
        default:
            
            print("")
        }
    }
    
    
    func scan() {
        
        let services: [CBUUID] = [CBUUID(string: "AAAAAAAA-7DD0-4B74-81D7-5E2114AB267E")]
        centralManager.scanForPeripherals(withServices: services, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print("did discover peripheral")

        let advDataes:[CBUUID]? = advertisementData["kCBAdvDataServiceUUIDs"] as? Array
        //        print("advDataes: \(advDataes?[0])")
        
        
        if let serviceUUID:CBUUID = advDataes?[0] {
            print("serviceUUID: \(serviceUUID)")
            
            if serviceUUID == CBUUID(string: "AAAAAAAA-7DD0-4B74-81D7-5E2114AB267E") {
                
                peripherals.append(peripheral)
                self.centralManager.connect(peripheral, options: nil)
                
            }
        }
        
        
    }
    
    func stop() {
        centralManager.stopScan()
    }
    
    //  成功時
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connect success!")
        
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        
        guard let services = peripheral.services else{
            print("error")
            return
        }
        
        for service in services {
            if service.uuid == CBUUID(string: "AAAAAAAA-7DD0-4B74-81D7-5E2114AB267E") {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
        print("\(services.count)個のサービスを発見。\(services)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        guard let characteristics = service.characteristics else{
            print("error")
            return
        }
        print("\(characteristics.count)個のキャラクタリスティックを発見。\(characteristics)")
        
        for characteristic in characteristics {
            
            peripheral.setNotifyValue(true, for: characteristic)
            
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        
        print("didWriteValueFor")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadValueFor characteristic: CBCharacteristic, error: Error?) {
        
        print("didReadValueFor")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        print((characteristic.value as! Data)[0])
        print("didUpdateValueFor")
        
        
        //        guard let data = characteristic.value else {
        //            return
        //        }
        //        if characteristic.uuid == Acceleration.UUID.characteristica.uuid || characteristic.uuid == Acceleration.UUID.characteristicb.uuid || characteristic.uuid == Acceleration.UUID.characteristicc.uuid {
        //            /// 通知を受け取ったらコールバックする
        //            print("get data:::")
        //            //let json = try JSONSerialization.jsonObject(with: data, options: [])
        //
        //            //print("get data:::\(String(describing: json))")
        //            //let dic: Dictionary? = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String : Any]
        //
        //            //let dic = data as! NSDictionary
        ////            do {
        ////                let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        ////                print(jsonData)
        ////
        ////            } catch _ {
        ////
        ////            }
        //
        //            do {
        //
        //                let decoded = try JSONSerialization.jsonObject(with: data, options: [])
        //                if let dictFromJSON = decoded as? [String:Int] {
        //
        //                    print("get data:::\(String(describing: dictFromJSON))")
        //
        //                }
        //
        //            } catch _ {
        //
        //
        //
        //            }
        //
        //            // you can now cast it with the right type
        //
        //
        ////            let str: String? = String(data: data, encoding: .utf8)
        ////            print(str?)
        ////            let dic: NSDictionary = str as [String : Int]
        ////
        ////
        //        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        
        print("didUpdateNotificationStateFor")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        
        print("didUpdateValueFor")
    }
    //  失敗時
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Connect failed...")
    }
    
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?){
        
        print("didDisconnectPeripheral")
        
    }
}
