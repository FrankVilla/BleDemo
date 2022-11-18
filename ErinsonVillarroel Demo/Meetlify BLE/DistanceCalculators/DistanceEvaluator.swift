//
//  DistanceEvaluator.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 19/11/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
protocol DistanceEvaluator: class {
    func distanceToClassifier(distance: Double) -> Classifier
    func calculateDistance(userId: String) -> DistanceEvaluatorResult
    func addRSSIToUserId(userId: String, RSSI: Double)
    func addTxPowerToUserId(userId: String, txPower: Double)
}
