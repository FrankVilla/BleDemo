//
//  DistanceEvaluatorResult.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 19/11/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation

class DistanceEvaluatorResult {
    let distance : Double
    let classifier : Classifier
    
    init(distance: Double, classifier: Classifier) {
        self.distance = distance
        self.classifier = classifier
    }
}
