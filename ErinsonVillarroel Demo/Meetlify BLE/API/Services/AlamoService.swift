//
//  Api.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 21/09/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import Alamofire

typealias AlamoSimpleResult = (_ error: Error?) -> ()
typealias AlamoSimpleStringResult = (_ error: String?) -> ()
typealias AlamoSimpleBoolResult = (_ error: Bool?) -> ()

class AlamofireService {
    
    var context: ApiContext
    
    init(context: ApiContext) {
        self.context = context
    }
    
    func get(at route: ApiRoute) -> DataRequest {
        return request(at: route, method: .get, encoding: JSONEncoding.default)
    }
    
    func post(at route: ApiRoute, params: [String: Any]?) -> DataRequest {
        return request(at: route, method: .post, params: params ?? [:], encoding: JSONEncoding.default)
    }
    
    func put(at route: ApiRoute, params: [String: Any]?, encoding: ParameterEncoding = JSONEncoding.default) -> DataRequest {
        return request(at: route, method: .put, params: params ?? [:], encoding: encoding)
    }
    
    func delete(at route: ApiRoute, params: [String: Any]?) -> DataRequest {
        return request(at: route, method: .delete, params: params ?? [:], encoding: JSONEncoding.default)
    }
    
    func request(at route: ApiRoute, method: HTTPMethod, params: Parameters = [:], encoding: ParameterEncoding) -> DataRequest {
        
        let url = route.url(for: context.apiUrl)
        
        let headers: HTTPHeaders = [
            "api-key": context.apiKey,
            "Accept": "application/json,image/jpeg",
            "Content-Type": "application/json"
        ]
        print("Start request: ", url)
        if (params.count > 0) {
            return AF
                .request(url, method: method, parameters: params, encoding: encoding, headers: headers)
                .validate()
                .validate(contentType: ["application/json"])
                .response { response in print("Got response:", url) }
                .response { response in print("Got response:", url, response) }
        } else {
            return AF
                .request(url, method: method, encoding: encoding, headers: headers)
                .validate()
                .validate(contentType: ["application/json", "image/jpeg"])
                .response { response in print("Got response:", url) }
                .response { response in print("Got response:", url, response) }
        }
    }
}
