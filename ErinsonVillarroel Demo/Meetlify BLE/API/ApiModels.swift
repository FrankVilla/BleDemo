//
//  ApiModels.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 06/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//
import Foundation

struct ApiUser : Codable {
    let id: String
    let name: String
    let pictureUrl: String
    let linkedInUrl: String
    let doNotDisturb: Bool
}

struct MessageError : Codable {
    let title: String
    let detail : String
}

struct ApiError : Codable {
    let status : Int
    let errors : [MessageError]
}

struct GenericModel<T : Codable> : Codable {
    let items : [T]
    let count : Int
}
