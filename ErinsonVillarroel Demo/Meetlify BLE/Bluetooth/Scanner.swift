//
//  Scanner.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 09/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import CoreBluetooth

class Scanner : NSObject, CBCentralManagerDelegate {
    
    private let serviceId = CBUUID(string: "0ADA")
    private var state : CBManagerState = CBManagerState.unknown
    private var locationUpdater : ((_ userId : String, _ rssi : NSNumber, _ power : Double) -> Void)? = nil
    
    var centralManager: CBCentralManager!
    var userIds : [CBUUID] = []
    var peripherals : [CBPeripheral] = []
    var deviceIdToUserUUID : [String : String] = [:]
    
    static let shared = Scanner()
    
    private override init() {
        super.init()
        self.userIds.append(serviceId)
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func addLocationUpdater(_ locationUpdater: @escaping (_ userId : String, _ rssi : NSNumber, _ power : Double) -> Void) {
        self.locationUpdater = locationUpdater
    }
    
    func removeListener() {
        self.locationUpdater = nil
    }
    
    func addUsersId(userIds : [CBUUID] = []) {
        self.userIds = userIds
    }
    
    func startScanning() {
        if (state == CBManagerState.poweredOn) {
            print("Start scanning")
            centralManager.scanForPeripherals(withServices: userIds, options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
        }
    }
    
    func stopScanning() {
        print("Stop scanning")
        if (state == CBManagerState.poweredOn) {
            centralManager.stopScan()
        }
    }
    
    private func handleManufacturerDataKey(_ advertisementData: [String : Any], _ power: Double, _ RSSI: NSNumber) {
        guard let manufacturerData = advertisementData[CBAdvertisementDataManufacturerDataKey] as! NSData? else {
            return
        }
        let manufacturerDataValue = manufacturerData.map{ String(format: "%02x", $0) }.joined()
        if (manufacturerDataValue.contains("da0a")) {
            let userUUID = manufacturerDataValue.replacingOccurrences(of: "da0a", with: "")
            locationUpdater!(userUUID, RSSI, power)
        }
    }
    
    private func handleDataServiceUUIDsKey(_ advertisementData: [String : Any], _ peripheral: CBPeripheral, _ power: Double, _ RSSI: NSNumber) {
        guard let servicesArray = (advertisementData[CBAdvertisementDataServiceUUIDsKey] as? NSArray) else {
            return
        }
        for i in 0..<servicesArray.count {
            let id = (servicesArray[i] as! CBUUID).uuidString
            if (id.count > 4) {
                deviceIdToUserUUID[peripheral.identifier.uuidString] = id
                locationUpdater!(id, RSSI, power)
            }
        }
    }
    
    private func handleOverflowServiceUUIDsKey(_ advertisementData: [String : Any], _ peripheral: CBPeripheral, _ power: Double, _ RSSI: NSNumber) {
        guard let servicesHashedArray = (advertisementData[CBAdvertisementDataOverflowServiceUUIDsKey] as? NSArray) else {
            return
        }
        guard let userId = deviceIdToUserUUID[peripheral.identifier.uuidString] else {
            if !self.peripherals.contains(where: { p in p.identifier.uuidString == peripheral.identifier.uuidString }) {
                self.peripherals.append(peripheral)
                centralManager.connect(peripheral, options: nil)
            }
            return
        }
        if (servicesHashedArray.contains(where: {
                                            u in (u as! CBUUID).uuidString  == userId
            
        })) {
            locationUpdater!(userId, RSSI, power)
        }
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            case .unknown:
                print("central.state is .unknown")
              case .resetting:
                print("central.state is .resetting")
              case .unsupported:
                print("central.state is .unsupported")
              case .unauthorized:
                print("central.state is .unauthorized")
              case .poweredOff:
                print("central.state is .poweredOff")
              case .poweredOn:
                print("central.state is .poweredOn")
        @unknown default:
            print("central.state is .default unknown")
        }
        state = central.state
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if (locationUpdater != nil) {
            guard let power = advertisementData[CBAdvertisementDataTxPowerLevelKey] as? Double else {
                return
            }
            handleManufacturerDataKey(advertisementData, power, RSSI)
            handleDataServiceUUIDsKey(advertisementData, peripheral, power, RSSI)
            handleOverflowServiceUUIDsKey(advertisementData, peripheral, power, RSSI)
        }
    }
    
    func centralManager(_ centralManager: CBCentralManager,
                            didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices(self.userIds)
    }
    
}
