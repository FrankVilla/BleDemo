//
//  TextFieldChanges.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 15/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
class TextFieldChanges: ObservableObject {

  var completion: (() -> ())?
  @Published var text = "" {
    didSet {}
  }
}
