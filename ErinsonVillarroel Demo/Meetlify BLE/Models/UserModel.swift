//
//  UserModel.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 13/09/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation

struct User : Codable, Identifiable{
    let id: String
    let name: String
    let pictureUrl: String
    let linkedInUrl: String?
    var doNotDisturb: Bool
    var distance: Double? = 0.0
    var picture: String?
    var classifier : Classifier = .temporarilyUnavailable
    var lastUpdateTimestamp : Double = 0
    
    init(name: String, picture: String, linkedInUrl: String?) {
        self.name = name
        self.picture = picture
        self.linkedInUrl = linkedInUrl
        self.doNotDisturb = false
        self.id = ""
        self.distance = -1.0
        self.pictureUrl = ""
        self.classifier = .temporarilyUnavailable
    }
    init(id: String, name: String, pictureUrl: String, linkedInUrl: String?, doNotDisturb: Bool) {
        self.name = name
        self.pictureUrl = pictureUrl
        self.linkedInUrl = linkedInUrl
        self.doNotDisturb = doNotDisturb
        self.id = ""
        self.distance = -1.0
        self.picture = ""
        self.classifier = .temporarilyUnavailable
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let name = try container.decodeIfPresent(String.self, forKey: .name) {
            self.name = name
        } else {
            self.name = ""
        }
        if let picture = try container.decodeIfPresent(String.self, forKey: .picture) {
            self.picture = picture
        } else {
            self.picture = ""
        }
        if let linkedInUrl = try container.decodeIfPresent(String.self, forKey: .linkedInUrl) {
            self.linkedInUrl = linkedInUrl
        } else {
            self.linkedInUrl = nil
        }
        if let doNotDisturb = try container.decodeIfPresent(Bool.self, forKey: .doNotDisturb) {
            self.doNotDisturb = doNotDisturb
        } else {
            self.doNotDisturb = false
        }
        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        } else {
            self.id = ""
        }
        if let distance = try container.decodeIfPresent(Double.self, forKey: .distance) {
            self.distance = distance
        } else {
            self.distance = -1.0
        }
        if let pictureUrl = try container.decodeIfPresent(String.self, forKey: .picture) {
            self.pictureUrl = pictureUrl
        } else {
            self.pictureUrl = ""
        }
        if let classifier = try container.decodeIfPresent(Classifier.self, forKey: .classifier) {
            self.classifier = classifier
        } else {
            if (self.doNotDisturb) {
                self.classifier = .doNotDisturb
            } else {
                self.classifier = .temporarilyUnavailable
            }
        }
        if let lastUpdateTimestamp = try container.decodeIfPresent(Double.self, forKey: .lastUpdateTimestamp) {
            self.lastUpdateTimestamp = lastUpdateTimestamp
        } else {
            self.lastUpdateTimestamp = 0.0
        }
    }
}
 
