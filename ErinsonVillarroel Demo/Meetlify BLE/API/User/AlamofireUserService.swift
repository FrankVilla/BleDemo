//
//  AlamofireUserService.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 28/09/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//
import Foundation
import Alamofire

class AlamofireUserService: AlamofireService, UserService {
    
    func createUser(user: User, completion: @escaping AlamoSimpleStringResult) {
        let params: [String: Any] = [
            "name" : user.name,
            "linkedInUrl": user.linkedInUrl,
            "picture" : "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",
            
        ]
        post(at: .users, params: params).response { response in
            var message: String?
            switch(response.result) {
                case .success:
                    message = nil
                    let userId = response.response?.allHeaderFields["Location"] as? String
                    let defaults = UserDefaults.standard
                    defaults.set(userId, forKey: AppDelegate.USER_ID)
                case .failure( _):
                    do {
                        if (response.data != nil) {
                            let decoder = JSONDecoder()
                            let error = try decoder.decode(ApiError.self, from: response.data!)
                            message = error.errors[0].detail
                        }
                    } catch {
                        print("JSONSerialization error:", error)
                        if let httpStatusCode = response.response?.statusCode {
                          message = "\(httpStatusCode)"
                       } else {
                          message = "Unknown error"
                       }
                    }
                    
             }
            completion(message)
        }
    }
    
    func getUsers(completion: @escaping UsersResult) {
        get(at: .users).responseJSON { response in
            let decoder = JSONDecoder()

            do {
                print(Result<Any, AFError>.success)
                if (response.data != nil) {
                    let models = try decoder.decode(GenericModel<User>.self, from: response.data!)
                    completion(models.items, response.error)
                } else {
                    completion([], response.error)
                }
                
            } catch {
                print(error)
                completion([], response.error)
            }
            
        }
    }
    
    func getUser(id: String, completion: @escaping UserResult) {
        get(at: .user(id: id)).responseJSON { response in
            let decoder = JSONDecoder()
            guard let data = response.data else {
                completion(nil, response.error)
                return
            }
            do {
                let model = try decoder.decode(User.self, from: data)
                completion(model, nil)
            } catch {
                print(error.localizedDescription)
                completion(nil, response.error)
            }
            
        }
    }
    
    func changdeDoNotDisturbMode(id: String, doNotDisturb: Bool, completion: @escaping AlamoSimpleBoolResult) {
        put(at: .doNotDisturb(id: id), params: [:], encoding: BodyStringEncoding(body: doNotDisturb)).response { response in
            var result : Bool
            switch(response.result) {
                case .success:
                   result = doNotDisturb
                case .failure( _):
                    result = !doNotDisturb
                    do {
                        if (response.data != nil) {
                            let decoder = JSONDecoder()
                            let error = try decoder.decode(ApiError.self, from: response.data!)
                        }
                    } catch {
                        print("JSONSerialization error:", error)
                        if let httpStatusCode = response.response?.statusCode {
                          print("\(httpStatusCode)")
                       } else {
                          print("Unknown error")
                       }
                    }
                    
             }
            completion(result)
        }
    }
}

