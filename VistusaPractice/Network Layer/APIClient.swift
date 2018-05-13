//
//  APIClient.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 13/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

protocol APIClient {
    
}

class APIClientImplementation:NSObject,APIClient {
    func fetchFact() -> Single<FactResponse>{
        
    }
}
