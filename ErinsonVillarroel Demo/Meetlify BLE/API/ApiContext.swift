//
//  ApiContext.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 21/09/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//


import Foundation

protocol ApiContext {
    var apiUrl: String { get }
    var apiKey: String { get }
}

class NonPersistentApiContext: ApiContext {
    private(set) var apiUrl: String
    private(set) var apiKey: String
    
    init(apiUrl: String, apiKey: String) {
        self.apiUrl = apiUrl
        self.apiKey = apiKey
    }
    
    init(fromEnv name: String) {
        let loadedUrl = getTextFromPlist(plistName: "ApiConfig-Info", text: "apiUrl")
        
        assert(loadedUrl != nil)
        
        self.apiUrl = loadedUrl!
        
        let loadedKey = getTextFromPlist(plistName: "ApiConfig-Info", text: "apiKey")
        
        assert(loadedKey != nil)
        
        self.apiKey = loadedKey!
    }
}

