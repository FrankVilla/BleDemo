//
//  AlamofirePhotoService.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 14/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class AlamofirePhotoService: AlamofireService, PhotoService {
    
    func getPhoto(_ userId: String, completion: @escaping PhotoDownloadResult) {
        get(at: .userPicture(id: userId)).responseImage { response in
            switch response.result {
            case let .success(value):
                ApiLayerController.shared.imageCache.add(value ,withIdentifier: userId)
                completion(value, nil)
            case let .failure(error):
                completion(nil, error)
            }
//            ApiLayerController.shared.imageCache.add(response ,withIdentifier: userId)
        }
    }
}
