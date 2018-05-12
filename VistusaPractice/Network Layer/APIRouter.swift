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
    
    var baseURL:String {
        return "https://dl.dropboxusercontent.com"
    }
    
    var path:String {
        switch self {
        case .fact:
            return "s/2iodh4vg0eortkl/facts.json"
        }
    }
    func asURLRequest() throws -> URLRequest {
        
    }
    
    
}
