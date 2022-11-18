//
//  Classifier.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 17/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation

enum Classifier : String , Codable {
    case veryClose = "Very close"
    case close = "Close"
    case nearby = "Nearby"
    case aBitFurther = "A bit further"
    case doNotDisturb = "Do not disturb"
    case temporarilyUnavailable = "Temporarily unavailable"
}

