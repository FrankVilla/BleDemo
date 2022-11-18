//
//  Enviroment.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 21/09/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation

func getDictFromPlist(name: String) -> NSDictionary? {
    var nsDictionary: NSDictionary?
    if let path = Bundle.main.path(forResource: name, ofType: "plist") {
       nsDictionary = NSDictionary(contentsOfFile: path)
    }
    
    return nsDictionary
}

func getTextFromPlist(plistName: String, text: String) -> String? {
    guard let dict = getDictFromPlist(name: "ApiConfig-Info") else {
        return nil
    }
    
    return getTextFromPlist(dict: dict, text: text)
}

func getTextFromPlist(dict: NSDictionary, text: String) -> String? {
    guard let value = dict[text] as? String else {
        return nil
    }
    
    return value
}

