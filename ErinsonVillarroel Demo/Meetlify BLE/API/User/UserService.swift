//
//  UserService.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 06/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation

typealias UserResult = (_ user: User?, _ error: Error?) -> ()
typealias UsersResult = (_ users: [User], _ error: Error?) -> ()

protocol UserService: class {
    func getUser(id: String, completion: @escaping UserResult)
    func getUsers(completion: @escaping UsersResult)
    func createUser(user: User, completion: @escaping AlamoSimpleStringResult)
    func changdeDoNotDisturbMode(id: String, doNotDisturb: Bool, completion: @escaping AlamoSimpleBoolResult)
}
