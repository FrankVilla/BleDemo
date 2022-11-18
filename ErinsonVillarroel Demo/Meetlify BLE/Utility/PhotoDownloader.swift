//
//  PeopleViewModel.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 07/10/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import UIKit

public class PhotoDownloader: ObservableObject {
    
    @Published var photo : UIImage! = UIImage(named: "Person")
    
    func load(id : String) {
        if let photo = ApiLayerController.shared.imageCache.image(withIdentifier: id) {
            self.photo = photo
        }
        else {
            ApiLayerController.shared.photoService.getPhoto(id) { (photo, error) in
                self.photo = photo ?? UIImage(named: "Person")!
            }
        }
        
    }
}
