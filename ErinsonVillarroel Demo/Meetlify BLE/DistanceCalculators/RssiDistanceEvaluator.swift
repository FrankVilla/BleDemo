//
//  BeaconDistanceRFCNewAttributeEvaluator.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 03/11/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import CoreML

class RssiDistanceEvaluator : DistanceEvaluator {
    
    static let shared = RssiDistanceEvaluator()
    
    private let NEGATIVE_DISTANCE_BOUNDARY_VALUE = -1.0
    private let MINIMUM_DISTANCE_BOUNDARY_VALUE = 0.0
    private let FIRST_DISTANCE_BOUNDARY_VALUE = 4.0
    private let SECOND_DISTANCE_BOUNDARY_VALUE = 8.0
    private let THIRD_DISTANCE_BOUNDARY_VALUE = 12.0
    private let MAXIMUM_DISTANCE_BOUNDARY_VALUE = 16.0
    
    private var userIdToRSSI : [String : [Double]] = [String : [Double]]()
    private var userIdToTxPower : [String : [Double]] = [String : [Double]]()
    private var userIdToLastResult : [String : DistanceEvaluatorResult] = [String : DistanceEvaluatorResult]()
    
    private init() {
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
    
    func getAverageTxPower(userId: String) -> Double {
        let rssi = (userIdToTxPower[userId]![0] + userIdToTxPower[userId]![1] + userIdToTxPower[userId]![2]) / 3
        return rssi;
    }
    
    func getAverageRSSI(userId: String) -> Double {
        let RSSI = (userIdToRSSI[userId]![0] + userIdToRSSI[userId]![1] + userIdToRSSI[userId]![2]) / 3
        return RSSI;
    }

    func calculeteRawDistance(txPower: Double, RSSI: Double) -> Double{
        let measuredPower = txPower - 64.2143
        let ratio = (RSSI * 1.0 / measuredPower)
        var distance = 0.0
        if (ratio < 1.0) {
            distance = pow(10, ratio)
        } else {
            distance = ((0.89976) * pow(7.7095, ratio) + 0.111)
        }
        return distance
    }

    func distanceToClassifier(distance: Double) -> Classifier {
        if (distance == NEGATIVE_DISTANCE_BOUNDARY_VALUE) {
            return Classifier.doNotDisturb
        } else if (distance > MINIMUM_DISTANCE_BOUNDARY_VALUE && distance < FIRST_DISTANCE_BOUNDARY_VALUE) {
            return Classifier.veryClose
        } else if (distance > FIRST_DISTANCE_BOUNDARY_VALUE && distance < SECOND_DISTANCE_BOUNDARY_VALUE) {
            return Classifier.close
        } else if (distance > SECOND_DISTANCE_BOUNDARY_VALUE && distance < THIRD_DISTANCE_BOUNDARY_VALUE) {
            return Classifier.nearby
        } else if (distance > THIRD_DISTANCE_BOUNDARY_VALUE && distance < MAXIMUM_DISTANCE_BOUNDARY_VALUE) {
            return Classifier.aBitFurther
        } else {
            return Classifier.temporarilyUnavailable
        }
    }
    
    func calculateDistance(userId: String) -> DistanceEvaluatorResult{
        if (canCalculate(userId: userId)){
            let averageTxPower = getAverageTxPower(userId: userId)
            let averageRSSI = getAverageRSSI(userId: userId)
            let distance = calculeteRawDistance(txPower: averageTxPower, RSSI: averageRSSI)
            let classifier = distanceToClassifier(distance: distance)
            clearRSSIToUserId(userId: userId)
            clearTxPowerToUserId(userId: userId)
            let result = DistanceEvaluatorResult(distance: distance, classifier: classifier)
            userIdToLastResult[userId] = result
            return result
        }
        return userIdToLastResult[userId] ?? DistanceEvaluatorResult(distance: 0, classifier: .temporarilyUnavailable)
    }
    
}
