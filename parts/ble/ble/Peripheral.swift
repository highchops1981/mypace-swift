//
//  Peripheral.swift
//  ble
//
//  Created by keisuke ishikura on 2017/11/15.
//  Copyright © 2017年 keisuke ishikura. All rights reserved.
//

import Foundation
import CoreBluetooth
import AVFoundation

class Peripheral: NSObject, CBPeripheralManagerDelegate {
    
    var peripheralManager: CBPeripheralManager!
    var bleDisConnedteCheckTimer: Timer!
    
    let char1 = CBMutableCharacteristic(
        type:CBUUID(string: "BBBBBBBB-62E1-45CC-9EF8-6747C01AD55A"),
        properties:[CBCharacteristicProperties.write,CBCharacteristicProperties.notify],
        value:nil,
        permissions:[CBAttributePermissions.writeable])
    
    let char2 = CBMutableCharacteristic(
        type:CBUUID(string: "CCCCCCCC-A596-4B5D-92BE-4D3A1892F989"),
        properties:[CBCharacteristicProperties.write],
        value:nil,
        permissions:[CBAttributePermissions.writeable])
    
    let char3 = CBMutableCharacteristic(
        type:CBUUID(string: "DDDDDDDD-9B1E-428F-96EC-BD708B34EF87"),
        properties:[CBCharacteristicProperties.write],
        value:nil,
        permissions:[CBAttributePermissions.writeable])
    
    var ready = false
    
    override init() {
        super.init()
        
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch (peripheral.state){
        case .poweredOn:
            ready = true
            advertise()
            
        default:
            ready = false
        }
    }
    
    func advertise() {
        
        let service = CBMutableService(type: CBUUID(string: "AAAAAAAA-7DD0-4B74-81D7-5E2114AB267E"), primary: true)
        service.characteristics = [char1,char2,char3]
        self.peripheralManager?.add(service)
        
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if error != nil {
            print("***Advertising ERROR")
            return
        }
        print("Advertising success::::\(peripheral)")
        
    }
    
    func stop() {
        
        peripheralManager.stopAdvertising()
        
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        if error != nil {
            return
        }
        
        var advertisementData: [String: Any] = [ CBAdvertisementDataServiceUUIDsKey: CBUUID(string: "AAAAAAAA-7DD0-4B74-81D7-5E2114AB267E")]
        advertisementData[CBAdvertisementDataLocalNameKey] = "YOUR LOCAL NAME"
        
        peripheralManager.startAdvertising(advertisementData)
        
    }
    
    @available(iOS 6.0, *)
    public func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        
        for request in requests {
            
            print(Date().description)
            
            let rValue = request.value!
            
            switch request.characteristic.uuid {
            case CBUUID(string: "BBBBBBBB-62E1-45CC-9EF8-6747C01AD55A"):
                print(rValue )
            case CBUUID(string: "CCCCCCCC-A596-4B5D-92BE-4D3A1892F989"):
                print(rValue)
            case CBUUID(string: "DDDDDDDD-9B1E-428F-96EC-BD708B34EF87"):
                print(rValue)

            default: break
            }
            
        }
        
        peripheralManager.respond(to: requests[0], withResult: .success)
        
    }
    
    deinit {
        self.bleDisConnedteCheckTimer?.invalidate()
    }
    
}


