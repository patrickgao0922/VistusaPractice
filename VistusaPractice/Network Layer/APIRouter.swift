//
//  APIRouter.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 12/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter:URLRequestConvertible {
    
    case fact
    
    fileprivate var baseURL:String {
        return "https://dl.dropboxusercontent.com"
    }
    
    fileprivate var method:HTTPMethod {
        switch self {
        case .fact:
            return .get
        }
    }
    
    fileprivate var path:String {
        switch self {
        case .fact:
            return "s/2iodh4vg0eortkl/facts.json"
        }
    }
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        return request
    }
}
