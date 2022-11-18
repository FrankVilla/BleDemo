//
//  UserDataHolder.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 25/11/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import Combine
class UserDataHolder: ObservableObject {
    @Published var user: User = User(id: "", name: "", pictureUrl: "", linkedInUrl: "", doNotDisturb: false)
    let defaults = UserDefaults.standard
    
    func save() throws {
        let encodedData = try PropertyListEncoder().encode(user)
        defaults.setValue(encodedData, forKey: AppDelegate.USER)
    }
    
    func load() throws {
        guard let data = defaults.value(forKey: AppDelegate.USER) as? Data else {
            throw UserError("There is no stored user")
        }
        let user = try PropertyListDecoder().decode(User.self, from: data)
        self.user = user
    }
    
    struct UserError : Error {
        let message: String

            init(_ message: String) {
                self.message = message
            }

            public var localizedDescription: String {
                return message
            }
    }
}
