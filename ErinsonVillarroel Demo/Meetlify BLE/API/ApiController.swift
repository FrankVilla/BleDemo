//
//  ApiController.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 06/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//
import Foundation
import UIKit
import AlamofireImage

class ApiLayerController {

    static let shared = ApiLayerController()
    var userService: AlamofireUserService!
    var photoService: AlamofirePhotoService!
    
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )

    init() {
        let context = NonPersistentApiContext(fromEnv: "api")
        userService = AlamofireUserService(context: context)
        photoService = AlamofirePhotoService(context: context)
    }
}
