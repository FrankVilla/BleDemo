//
//  BodyStringEncoding.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 25/11/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import Foundation
import Alamofire

struct BodyStringEncoding: ParameterEncoding {

    private let body: Bool

    init(body: Bool) { self.body = body }

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        guard var urlRequest = urlRequest.urlRequest else { throw Errors.emptyURLRequest }
        urlRequest.httpBody = try! JSONEncoder().encode(body)
        return urlRequest
    }
}

extension BodyStringEncoding {
    enum Errors: Error {
        case emptyURLRequest
    }
}

extension BodyStringEncoding.Errors: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .emptyURLRequest: return "Empty url request"
        }
    }
}
