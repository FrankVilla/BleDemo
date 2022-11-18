//
//  ModelEvaluator.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 03/11/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import CoreML

class BeaconDistanceRFCEvaluator : DistanceEvaluator {
    
    static let shared = BeaconDistanceRFCEvaluator()
    
    private var model : Beacon_distance_RFC?
    private var userIdToRSSI : [String : [Double]] = [String : [Double]]()
    private var userIdToTxPower : [String : [Double]] = [String : [Double]]()
    private var userIdToLastResult : [String : DistanceEvaluatorResult] = [String : DistanceEvaluatorResult]()
    
    private init() {
        let config = MLModelConfiguration()
        do {
            try model = Beacon_distance_RFC(configuration: config)
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
    
    func calculateModifiedRSSI(RSSI: Double, txPower: Double) -> Double {
        let measuredPower = txPower - 64.2143
        return RSSI - measuredPower
    }
    
    func canCalculate(userId: String) -> Bool {
        return userIdToRSSI[userId]!.count > 2
    }
    
    func calculateDistance(userId: String) -> DistanceEvaluatorResult{
        if (canCalculate(userId: userId)){
            do {
                let firstRSSI = calculateModifiedRSSI(RSSI: userIdToRSSI[userId]![0], txPower: userIdToTxPower[userId]![0])
                let secondRSSI = calculateModifiedRSSI(RSSI: userIdToRSSI[userId]![1], txPower: userIdToTxPower[userId]![1])
                let thirdRSSI = calculateModifiedRSSI(RSSI: userIdToRSSI[userId]![2], txPower: userIdToTxPower[userId]![2])
                let modelClassifier =  try model?.prediction(input: Beacon_distance_RFCInput(first_rssi: firstRSSI, second_rssi: secondRSSI, third_rssi: thirdRSSI))
                let classifier = distanceToClassifier(distance: Double(modelClassifier!.distance))
                clearRSSIToUserId(userId: userId)
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
