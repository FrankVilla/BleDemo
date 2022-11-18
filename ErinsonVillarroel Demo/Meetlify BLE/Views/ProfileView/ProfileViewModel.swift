//
//  ProfileViewModel.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 15/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import Foundation
import CoreBluetooth

public class ProfileViewModel: ObservableObject {
   
    @Published var user : User? = nil
    @Published var error : Error? = nil
    @Published var showLoader : Bool = true
    @Published var doNotDisturb : Bool = false
    private let defaults = UserDefaults.standard
    private var myId : String?
    
    init(){
        myId = defaults.string(forKey: AppDelegate.USER_ID)
        load(myId!)
    }
    
    func load(_ id: String) {
        self.showLoader = true
        ApiLayerController.shared.userService.getUser(id: id) { (user, error) in
            self.showLoader = false
            guard let e = error else {
                self.error = nil
                self.user = user!
                self.doNotDisturb = user!.doNotDisturb
                return
            }
            self.error = e
        }
    }
}
