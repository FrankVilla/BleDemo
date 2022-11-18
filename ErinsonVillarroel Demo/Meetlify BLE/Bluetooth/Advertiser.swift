//
//  Advertiser.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 09/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import CoreBluetooth

class Advertiser : NSObject, CBPeripheralManagerDelegate {
    
    private var peripheralManager : CBPeripheralManager!
    private var service: CBUUID!
    private var userService: CBUUID!
    private static let serviceId = "0ADA"
    private let defaults = UserDefaults.standard
    private var myId : String?
    private var state : CBManagerState = .unknown
    
    static let shared = Advertiser()
    
    private override init() {
        super.init()
        myId = defaults.string(forKey: AppDelegate.USER_ID)
        service = CBUUID(string: Advertiser.serviceId)
        userService = CBUUID(string: myId!)
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func startAdvertising() {
        if (state == .poweredOn) {
            print("Start Advertising")
            let characteristic = CBMutableCharacteristic(type: userService,
                                      properties: [.write, .notify],
                                      value: nil,
                                      permissions: .writeable)
            let service = CBMutableService(type: self.userService, primary: true)
            service.characteristics = [characteristic]

            peripheralManager.add(service)
            peripheralManager.startAdvertising([CBAdvertisementDataLocalNameKey : "Meetlify", CBAdvertisementDataServiceUUIDsKey : [service.uuid, self.service]])
        }
    }
    
    func stopAdvertising() {
        print("Stop Advertising")
        peripheralManager.stopAdvertising()
        
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        state = peripheral.state
        switch peripheral.state {
        case .unknown:
            print("peripheral.state is .unknown")
          case .resetting:
            print("peripheral.state is .resetting")
          case .unsupported:
            print("peripheral.state is .unsupported")
          case .unauthorized:
            print("peripheral.state is .unauthorized")
          case .poweredOff:
            print("peripheral.state is .poweredOff")
          case .poweredOn:
            print("peripheral.state is .poweredOn")
            startAdvertising()
        @unknown default:
            print("peripheral.state is .default unknown")
        }
        
    }
}
