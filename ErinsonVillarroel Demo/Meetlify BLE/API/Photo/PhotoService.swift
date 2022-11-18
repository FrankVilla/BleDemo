//
//  PhotoService.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 14/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import UIKit

typealias PhotoDownloadResult = (_ downloadedImage: UIImage?, _ error: Error?) -> ()

protocol PhotoService: class {
    func getPhoto(_ userId: String, completion: @escaping PhotoDownloadResult)
}

