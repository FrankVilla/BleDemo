//
//  BeaconDistanceRFCNewAttributeEvaluator.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 03/11/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import CoreML

class BeaconDistanceRFCNewAttributeEvaluator : DistanceEvaluator {
    
    static let shared = BeaconDistanceRFCNewAttributeEvaluator()
    
    private var model : Beacon_distance_RFC_newAttribute?
    private var userIdToRSSI : [String : [Double]] = [String : [Double]]()
    private var userIdToTxPower : [String : [Double]] = [String : [Double]]()
    private var userIdToLastResult : [String : DistanceEvaluatorResult] = [String : DistanceEvaluatorResult]()
    
    private init() {
        let config = MLModelConfiguration()
        do {
            try model = Beacon_distance_RFC_newAttribute(configuration: config)
        } catch {
            print(error)
        }
    }
    
    func addRSSIToUserId(userId: String, RSSI: Double) {
        if (userIdToRSSI[userId] == nil) {
            userIdToRSSI[userId] = []
        }
        userIdToRSSI[userId]!.append(RSSI)
    }
    
    func clearRSSIToUserId(userId: String) {
        userIdToRSSI[userId]!.removeAll()
    }
    
    func addTxPowerToUserId(userId: String, txPower: Double) {
        if (userIdToTxPower[userId] == nil) {
            userIdToTxPower[userId] = []
        }
        userIdToTxPower[userId]!.append(txPower)
    }
    
    func clearTxPowerToUserId(userId: String) {
        userIdToTxPower[userId]!.removeAll()
    }
    
    
    func canCalculate(userId: String) -> Bool {
        return userIdToRSSI[userId]!.count > 2 && userIdToTxPower[userId]!.count > 2
    }
    
    func calculateMessuredPower(userId: String) -> Double {
        let rssi = ((userIdToTxPower[userId]![0] + userIdToTxPower[userId]![1] + userIdToTxPower[userId]![2]) / 3) - 64.2143
        return rssi;
    }
    
    func calculateDistance(userId: String) -> DistanceEvaluatorResult {
        if (canCalculate(userId: userId)) {
            do {
                let messuerdPower = calculateMessuredPower(userId: userId)
                let modelClassifier =  try model?.prediction(input: Beacon_distance_RFC_newAttributeInput(
                                                                first_rssi: userIdToRSSI[userId]![0],
                                                                second_rssi: userIdToRSSI[userId]![1],
                                                                third_rssi: userIdToRSSI[userId]![2],
                                                                power_1m: messuerdPower)
                )
                let classifier = distanceToClassifier(distance: Double(modelClassifier!.distance))
                clearRSSIToUserId(userId: userId)
                clearTxPowerToUserId(userId: userId)
                let result = DistanceEvaluatorResult(distance: Double(modelClassifier!.distance), classifier: classifier)
                userIdToLastResult[userId] = result
                return result
            } catch {
                print(error)
            }
        }
        return userIdToLastResult[userId] ?? DistanceEvaluatorResult(distance: 0, classifier: .temporarilyUnavailable)
    }
    
    func distanceToClassifier(distance: Double) -> Classifier {
        switch distance {
        case 0:
            return .aBitFurther
        case 1:
            return .nearby
        case 2:
            return .close
        case 3:
            return .veryClose
        default:
            return .temporarilyUnavailable
        }
    }
}
