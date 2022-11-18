//
//  PeopleViewModel.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 07/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import CoreBluetooth

public class UsersViewModel: ObservableObject {
    var lastUpdateTimestamp : Double = 0
    @Published var users = [User]()
    @Published var error : Error? = nil
    @Published var showLoader : Bool = true
    @Published var isRefreshing : Bool = false
    let defaults : UserDefaults
    
    init(){
        defaults = UserDefaults.standard
        load()
        Advertiser.shared.startAdvertising()
        Scanner.shared.addLocationUpdater(self.updateUserLocation)
    }
    
    func load() {
        self.showLoader = true
        ApiLayerController.shared.userService.getUsers { (users, error) in
            let myId = self.defaults.string(forKey: AppDelegate.USER_ID)
            let usersWithoutMe = users.filter{ $0.id != myId }
            let usersId = usersWithoutMe.map { CBUUID(string: $0.id) }
            Scanner.shared.stopScanning()
            Scanner.shared.addUsersId(userIds: usersId)
            Scanner.shared.startScanning()
            self.showLoader = false
            self.isRefreshing = false
            guard let e = error else {
                self.error = nil
                self.users = usersWithoutMe
                return
            }
            self.error = e
        }
    }
    
    func reload() {
        self.isRefreshing = true
        Scanner.shared.stopScanning()
        load()
    }
    
    func updateUserLocation(id: String, RSSI : NSNumber, power : Double) {
            let unifiedId = id.replacingOccurrences(of: "-", with: "").uppercased()
            
            if let i = self.users.firstIndex(where: { $0.id.replacingOccurrences(of: "-", with: "").uppercased().contains(unifiedId) }) {
                let evaluatorConfig = defaults.string(forKey: AppDelegate.EVALUATOR_CONFIG)
                var distanceEvaluator : DistanceEvaluator
                switch evaluatorConfig {
                    case DistanceEvaluatorConfiguration.RAW.rawValue:
                        distanceEvaluator = RssiDistanceEvaluator.shared
                    case DistanceEvaluatorConfiguration.ML_STANDARD.rawValue:
                        distanceEvaluator = BeaconDistanceRFCEvaluator.shared
                    case DistanceEvaluatorConfiguration.ML_NEW.rawValue:
                        distanceEvaluator = BeaconDistanceRFCNewAttributeEvaluator.shared
                    default:
                        distanceEvaluator = BeaconDistanceRFCNewAttributeEvaluator.shared
                }
                distanceEvaluator.addRSSIToUserId(userId: unifiedId, RSSI: RSSI.doubleValue)
                distanceEvaluator.addTxPowerToUserId(userId: unifiedId, txPower: power)
                if (isValidTimeInterval(self.users[i].lastUpdateTimestamp)) {
                    let result = distanceEvaluator.calculateDistance(userId: unifiedId)
                    self.users[i].distance = result.distance
                    self.users[i].classifier = result.classifier
                    self.users[i].lastUpdateTimestamp = NSDate().timeIntervalSince1970
                }
        }
    }
    
    private func isValidTimeInterval(_ lastUpdateTimestamp : Double) -> Bool {
        if (lastUpdateTimestamp == 0) {
            return true;
        }
        return NSDate().timeIntervalSince1970 - lastUpdateTimestamp > 3
    }
}
