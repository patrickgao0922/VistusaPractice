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

enum HTTPError:Error{
    case noResultData
    case jsonParsingError
    case imageParsingError
}

class APIClientImplementation:NSObject,APIClient {
    
    func fetchFact() -> Single<FactResponse>{
        return Single<FactResponse>.create(subscribe: { (single) -> Disposable in
            let dispatchQueue = DispatchQueue(label: "com.patrickgao.VistusaPractice")
            dispatchQueue.async {
                request(APIRouter.fact)
                    .responseString(completionHandler: { (response) in
                        guard let jsonString = response.result.value else {
                            return single(.error(HTTPError.noResultData))
                        }
                        guard let factResponse = FactResponse(JSONString: jsonString) else {
                            return single(.error(HTTPError.jsonParsingError))
                        }
                        single(.success(factResponse))
                    })
            }
            return Disposables.create()
        })
    }
}

struct FactResponse:Mappable {
    init?(map: Map) {
        
    }
    
    var title:String?
    var rows:[Row]?
    mutating func mapping(map: Map) {
        title <- map["title"]
        rows <- map["rows"]
    }
}

struct Row:Mappable{
    
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
