//
//  ApiRoute.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 21/09/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation

enum ApiRoute { case
    
    currentLocations,
    currentLocation(id: String),
    locations,
    measurements,
    users,
    user(id: String),
    userPicture(id: String),
    doNotDisturb(id: String)
    
    var path: String {
        switch self {
            case .currentLocations: return "current-locations"
            case .currentLocation(let id): return "current-locations/\(id)"
            case .locations: return "locations"
            case .measurements: return "measurements"
            case .users: return "users?PageSize=150"
            case .user(let id): return "users/\(id)"
            case .userPicture(let id): return "users/\(id)/picture"
            case .doNotDisturb(let id): return "users/\(id)/do-not-disturb"
        }
    }
    
    func url(for apiUrl: String) -> String {
        return "\(apiUrl)/\(path)"
    }
}
