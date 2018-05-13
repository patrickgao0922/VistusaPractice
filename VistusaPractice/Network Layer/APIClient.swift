//
//  APIClient.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 13/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import ObjectMapper

protocol APIClient {
    func fetchFact() -> Single<FactResponse>
}

class APIClientImplementation:NSObject,APIClient {
    func fetchFact() -> Single<FactResponse>{
        return Single<FactResponse>.create(subscribe: { (single) -> Disposable in
            request(APIRouter.fact)
//                .responseString(completionHandler: <#T##(DataResponse<String>) -> Void#>)
            return Disposables.create()
        })
    }
}

struct FactResponse:Mappable {
    init?(map: Map) {
        
    }
    
    var title:String?
    var rows:[Fact]?
    mutating func mapping(map: Map) {
        title <- map["title"]
        rows <- map["rows"]
    }
}

struct Fact:Mappable{
    
    var title:String?
    var description:String?
    var imageHref:String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        description <- map["description"]
        imageHref <- map["imageHref"]
    }
    
    
}
