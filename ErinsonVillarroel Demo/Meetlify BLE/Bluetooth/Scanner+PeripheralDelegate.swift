//
//  Scanner+PeripheralDelegate.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 19/11/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import CoreBluetooth

extension Scanner : CBPeripheralDelegate {
 
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
      if let error = error {
        print("Unable to discover services: \(error.localizedDescription)")
        return
      }
      peripheral.services?.forEach { service in
        peripheral.discoverCharacteristics(self.userIds, for: service)
      }
    }
    
    func peripheral(_ peripheral: CBPeripheral,
          didDiscoverCharacteristicsFor service: CBService, error: Error?) {
      if let error = error {
        print("Unable to discover characteristics: \(error.localizedDescription)")
        return
      }
      service.characteristics?.forEach { characteristic in
        deviceIdToUserUUID[peripheral.identifier.uuidString] = characteristic.uuid.uuidString
        centralManager.cancelPeripheralConnection(peripheral)
        if let indexOfUnnesseseryPeripheral = self.peripherals.firstIndex(of: peripheral) {
            self.peripherals.remove(at: indexOfUnnesseseryPeripheral)
        }
      }
    }
    
}
